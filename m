Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207D0C25B79
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 06:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAOcH-0001Jw-Du; Fri, 24 May 2024 02:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sAOcD-0001Gs-GU; Fri, 24 May 2024 02:41:21 -0400
Received: from fanzine.igalia.com ([178.60.130.6] helo=fanzine2.igalia.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berto@igalia.com>)
 id 1sAOcB-0006jf-9c; Fri, 24 May 2024 02:41:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Type:MIME-Version:Message-ID:Date:References:
 In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=r6J2cScsrls6NhCnny+nYV6X+cM7ogV5s9Sqigrq/U4=; b=dfYr6uDUZCLUyvP6IgGE8bIrgr
 B9Ba/pUyteL11ZKNFuqXasJcNtcqBFb+dyRPJ1BsS5Tp5q6XnLyBEaIphA1fNzOS1PxH0DfkWrNKO
 JbWb+LOdepUtU34IZ/U6MzOYFU6QTEMBOPPsMhCVcri/63R+eNxSheOlPBqsZZvFDr1RFy+VRHmy9
 o74hw9Wz9mibQjRXcS4avo0MTZKPPvA5H4BSvlif7OstX8FHUgcXiKWno1TrMp9nJzy380qZg8HVI
 iTI8motWmJuFJwU2BNJ/jrpa7OUcB/fHn70NlwHklasi5VUZe47OBoGJd775sskFCSUOrPpR0Su7U
 qMgQp07A==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtps 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1sAOc8-00Bt2d-SE; Fri, 24 May 2024 08:41:16 +0200
Received: from gate.service.igalia.com ([192.168.21.52])
 by mail.igalia.com with esmtp (Exim)
 id 1sAOc6-00AebZ-Nu; Fri, 24 May 2024 08:41:16 +0200
Received: from berto by gate.service.igalia.com with local (Exim 4.96)
 (envelope-from <berto@igalia.com>) id 1sAOc6-007CJB-1r;
 Fri, 24 May 2024 06:41:14 +0000
From: Alberto Garcia <berto@igalia.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, jean-louis@dupond.be, andrey.drobyshev@virtuozzo.com,
 den@virtuozzo.com
Subject: Re: [PATCH v2 05/11] iotests/common.rc: add disk_usage function
In-Reply-To: <20240513063203.113911-6-andrey.drobyshev@virtuozzo.com>
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-6-andrey.drobyshev@virtuozzo.com>
Date: Fri, 24 May 2024 08:41:14 +0200
Message-ID: <w51ikz3iuet.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=178.60.130.6; envelope-from=berto@igalia.com;
 helo=fanzine2.igalia.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon 13 May 2024 09:31:57 AM +03, Andrey Drobyshev wrote:
> Move the definition from iotests/250 to common.rc.  This is used to
> detect real disk usage of sparse files.  In particular, we want to use
> it for checking subclusters-based discards.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto

