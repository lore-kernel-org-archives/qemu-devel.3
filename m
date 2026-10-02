Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18347CA5FE0
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 17:23:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCgyO-0000bP-O5; Fri, 02 Oct 2026 13:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwp-0008Ik-7c
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCgwm-0003Os-Fl
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 13:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790961683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oH+EjKBOvZNxaxHtrr0XaL3d72ADKzkKMiSpKNfR0uA=;
 b=bBXj5oAmqUlwE/cofKAnRl1E8CWzQS5AQpvmPcO96f44OGgNoQ38z6WSY7ZjCsOxu1CrVf
 xHuksSf6zCEHc1SpH6MvLNpMmxy5Wf9PDrKlYYaFiI0rVNAMJJA7YGB77P7vzi8wMrtqXs
 Zl2DZhubvvjn0r1ybB6ZHkHFZWrmLeM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-196-az_NJf-kOyu3aex70inJ2A-1; Fri,
 02 Oct 2026 13:21:19 -0400
X-MC-Unique: az_NJf-kOyu3aex70inJ2A-1
X-Mimecast-MFC-AGG-ID: az_NJf-kOyu3aex70inJ2A_1790961678
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 402651806D3D; Fri,  2 Oct 2026 17:21:18 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A1BC180049F; Fri,  2 Oct 2026 17:21:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 02/28] accel: mark kvm and xen accelerators as secure
From: marcandre.lureau@redhat.com
To: =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, 
 qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org, 
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org
In-Reply-To: <20260911143627.2743803-3-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
 <20260911143627.2743803-3-berrange@redhat.com>
Date: Fri, 02 Oct 2026 21:21:01 +0400
Message-Id: <179096166110.3025252.11073058761964969846.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=525;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=yz+AxESUJKfoqLf9T6OMvfiNfNPqI2ffYywuPWoFITA=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqv+gBL/4DdV1bzfqvy1Lc0bKI3IgDZ3n1OxYVe
 PnKzvMU5pmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar/oAQAKCRDa6OEJdZac
 5ST0EACA7qPlq4uLz4A2t+3VSo1TE1nKGiHl2ypJyBuBXQbagr4O1+xM8ICqd5gXhNYVfUK+NPu
 P4qqWqZRCXyDlpawmpOYFOPHBCB7xi4fC1A07wdZXmxSqoJq3X3RYgjUGzBUECqBXhqCCzcb0iH
 oXPHxHF8LFkQmzEfHkuIzHaGDO3mEQou2chNp3BzCxmu9aNxNS7CeaTjdEQqu/CGKBhHBqFvbBs
 bq2cJmj5eaPEeBJiO1KdMRBnZ+YvceJPKyzxcYR6wsG+PAeyO+VFfdLPNO9AtxTdgmHHKS2/spH
 h3kQyh3BPPGQjjGJoOfgTWlBY8v2ehj7ONk5dKnqb6xLprMYoQdadWVL1hZhGbp4xctsHlHU3ar
 ykhAslxBt0HDv32FzisCsNNrgHuWnoOSaGYhmzYo7cqDoIFtuWwnWghugfFRWPe2RE4NN8KR1jZ
 5+5/Tj7NvAeTdGypid/9pN9Zmsgahyvi21TJYVaUVkhsXf5RCliwYJ1ptLKYKvBuo8VUSR5w7Ag
 yvx2rfKlDXAx5NpfOhMfedwS9Cn6SCRzkS9bzeAraPlA7mt7jDLkxHd+DoRVkzVpHOOJ0d2PBSr
 56KQeH/2ltCikTn2GhfE/4fQCYd9qMcAjC3F+I7iUnxxjTCUVAGKMI2xd31P85YrE+iLwD40qZc
 BK7SswdL2a3g+PQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.336,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 11 Sep 2026 15:36:01 +0100, Daniel P. Berrangé <berrange@redhat.com> wrote:
> TCG is too complex to be considered to provide a security boundary
> for malicious guest workloads. QTest is only used for functional
> testing and thus is not relevant to mark secure.
> 
> KVM and Xen are servicing virtualization use cases which must
> provide security and actively maintained.
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


