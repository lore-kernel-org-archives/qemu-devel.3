Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61253CA5FB3
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDJl-0005zI-1M; Thu, 01 Oct 2026 05:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJk-0005z9-6X
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xCDJi-0003NC-RT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790847786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w28hSXZeuhAbARcvWDSGPsTK/BM8wdBwnzlkmd63weU=;
 b=Wm4NfbOwijnvxC8xw4d5ISQvB6hqGADtEpDw4uOpUMZU+yqNWY0/7dhTKrB8hUzla3zhJe
 O3udvKPD0vSFvl0w/QDYOC3yXgLutl5QnkzhbmgHU80mDCtD5UqMWeTl1uTH/TgDIuQNcZ
 bHjQ5aPb8XodIyrUSNADoqjsA0gyrh0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-xv5HNH36NwWpfCsIGcBnwg-1; Thu,
 01 Oct 2026 05:43:04 -0400
X-MC-Unique: xv5HNH36NwWpfCsIGcBnwg-1
X-Mimecast-MFC-AGG-ID: xv5HNH36NwWpfCsIGcBnwg_1790847784
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E14141835D41; Thu,  1 Oct 2026 09:43:03 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 23B6C30001A2; Thu,  1 Oct 2026 09:43:02 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 07/11] qemu-option: Add qemu_opts_parse_list_noisily
From: marcandre.lureau@redhat.com
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
In-Reply-To: <20260930221105.2262063-8-farosas@suse.de>
References: <20260930221105.2262063-1-farosas@suse.de>
 <20260930221105.2262063-8-farosas@suse.de>
Date: Thu, 01 Oct 2026 13:42:36 +0400
Message-Id: <179084775655.2086187.33391413113621003.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=508;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=wiOE10Xcbg8EK3TprKQIL0BA123LYEvAKHZNuyMR6U0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqvisPS6/YVEGTcin/A4HoORZn8u+Q+fRxP8b93
 rjq9xJs05SJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCar4rDwAKCRDa6OEJdZac
 5eRCD/90s1GoCy2qT+25mH3FgoT3HxzOjpboAgnrZnFMuT8DZUg22r2BgdiIQLuFh6+SAgVMFhw
 bh71GcTWzA1DMbmvaFMJ5bsAfJim4eUrYpcgEqD2aLNkawLMcG9gNMx9dRJ2SSvvfqsrEf8hBqz
 mVRLq2x2Uo/xKC0fKkS7SqYdfj8FYOJ8T2UiENE2BCzz6bHs2HDgmsFk2FKWdULFasMCMoRI9RT
 UOCsODHvGzCMt6YAVGRb19qeofuOAMiOhU3rCVcjVceZw6EUsOhhfwy1+1K/E4pfCNKLZTAk168
 uuM4vk4/jE9f5oFsJkCO1DwozEoiM8nb4mKBgfJ9UuaiRFnKBjWoSbmTwqYivUMIv0fYaXJOO9g
 TncNM65A0DN60F87B+TUwu7S7eJEaGIQGLsSC8kt5zRN+qQpG3Cz388nkApyMsrYoCMd8SyEASn
 CZ35wkim/rEBM4txAe3rideJh04Mxd7n27c6QiRU1/eLJx38laASXieUFIb5eEBwz0ypLm0WUrn
 T/a8Wyn2OBCfvPltH/AuYYrn1tUmqMfhShjSCvc9sbtqWNg0qMArElQNFhPpv0/Wrz5WXZ7sqUf
 6YboTMsV/VlgoprrXfUhTnFBUc/8SjAqcXlH43JbLpBVtm7/kEwvGQ+vF4Tz9g+tZUaIs1kKpJe
 QmkCoACMDjDIhug==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 30 Sep 2026 19:11:01 -0300, Fabiano Rosas <farosas@suse.de> wrote:
> Add a new function that takes a QemuOptsList pointer and expects
> informative messages to be printed instead of returned in an Error
> object. This makes the _noisily version simmetric with the
> "non-noisily". The next patch will convert the callers to use the
> appropriate version.
> 
> 
> [...]

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


