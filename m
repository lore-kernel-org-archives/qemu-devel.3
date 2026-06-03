Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DF0CD6E64
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 10:29:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUiqK-0001Nw-SY; Wed, 03 Jun 2026 06:29:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUiqH-0001NU-Dd
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:28:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1wUiqF-0000ea-PQ
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 06:28:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780482534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuSZf5jDoUi8hZM6Ed6bmlnVNhA/knGzl3cxv/wfe0A=;
 b=JYhR2ZESCXDU7AkWZN2KwQKpTk9DDWK2HNc/8R8+0v2xJ1W51SzxsoCoHS0CZdxIy3UVyX
 48Eujbm3a0yYFxnE37qrIK5iBebmJHsegnRYiC5nNAW0BHCLm8t4sbI9kvn6za58iMWHXu
 Scf7Y8FmGtG8XIqSz6ywtaPKyi183f8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-srs-tNtvM-eE3jg0sxmmyw-1; Wed, 03 Jun 2026 06:28:52 -0400
X-MC-Unique: srs-tNtvM-eE3jg0sxmmyw-1
X-Mimecast-MFC-AGG-ID: srs-tNtvM-eE3jg0sxmmyw_1780482531
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490aadb1386so2724025e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jun 2026 03:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780482531; x=1781087331; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QuSZf5jDoUi8hZM6Ed6bmlnVNhA/knGzl3cxv/wfe0A=;
 b=DDEnuRmDXk28qs+JLP1mmhZxiDi+B1nMfZYaXFOrXq8cBBOCh0rva+RgTc7sVQ1Qf1
 4lfljrNP5XkSJL0tx3MBYYinspvDSVfCoigNZmFpHyAP1ClvEn6USRopFdNKjkNIO+rp
 o+84O3VWDVf2P1eyunYN2ierm1Ut4W44w2g0w5RxLFom+wCJhYyrr/jN5wMijwU2J7We
 2tX/Uy/YcxOI8JPKHIGI4Skjw4IFjWQEpigVb3WVW4jFrFt0PVOS2kBG3P9ByjKO8heD
 CocuzEn8SpWcACkJ6Dus0npDM/qc41UWqrJ8NttvnNVCAJ8Huzj0z/lWRlTyaqMQqa+c
 9pZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780482531; x=1781087331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QuSZf5jDoUi8hZM6Ed6bmlnVNhA/knGzl3cxv/wfe0A=;
 b=c9Vo0oQFPWzo1h/vOCYP2pmT5M+e5YIytuLXsltTWB+Ev9K6SFSbp8xzXvo7yJ9Hgp
 4tzxg0hzV+DdojgVy9Bf2QuFtdLxdueXu6qoaf+7C4hK9UKHC1MrwQTB2sB7BJ09x7EZ
 qV3K8cijr57jpDyVWAFpf0LSRUWAtSm2WmcIk5om2O8Xm1dcz4mBUTrZ01y8t3L+D/HW
 A7rYysM5cCAOiM3AtTEDlVAglUBFioPebuSdjnDGDTS/4nqJ0SS2ysvARpCvj33WAaiS
 O2BSMHK9spy+Nr1SrnqHMgI0z0fJNlJU9WpWP3Q34DJ+yotH8imy0WrM8GCX+zOG2zlp
 vYmQ==
X-Gm-Message-State: AOJu0YwpOX7vmStphVcfZGXip/XsetOFLgt7+/QdUzv1v+r+8pH3PmKc
 eSAJr8xcsq9s3DSY5cUXw7N9JSC+DM170UPQMI6+kP02QfmBSeKNgxAIZFfu5QkhUu4preAFhIK
 Sfu4xZUPYPmawALq/E7pQWFPrTKXI2TexwmIdtTg1u4OO3hIY0dMQAw+C
X-Gm-Gg: Acq92OGx8+mn7RMa8GAgZDs882F+z2iuIoZmdC5Fwevd3d7XRKR8baw8q2v+LD+08K/
 kLndH+IPQnI7pzzVrhcRXyYYXf4bq9qUYdsVhyVjDKpYwAz9hdBROuvxYU3uITHoDvjbJ/cdDn3
 s+8KPsS21Az1GOwda66+PiB0nGOToiq6wS0ASbHFaxeoJi+nwzU/ALqfMLyNLepZHZfjpDD2Xgo
 t6XUZObYXhKwvAV/t2lAGnUkTMG51tP1nT52fUiIMmaCJ6al78VU+2nqrnVOCTpNKd6VSLp3gZ4
 r2sANxe6wupMyfSvADFVbJK9ZKYgYc06vDznLxXVIfJftkButlErIdzvoaTt84lsLH1lrMa+ZEP
 PyhblkDeVZjFgrnOn5olzzfwc8tZgsB5M+qCd5Eowm1oLdrY6viJwtlZ7U0/Oea25QBh4nIrS9G
 cYGy4oyw==
X-Received: by 2002:a05:600c:468d:b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-490b611af3bmr44592735e9.6.1780482531419; 
 Wed, 03 Jun 2026 03:28:51 -0700 (PDT)
X-Received: by 2002:a05:600c:468d:b0:488:7d01:f67b with SMTP id
 5b1f17b1804b1-490b611af3bmr44592185e9.6.1780482530914; 
 Wed, 03 Jun 2026 03:28:50 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it.
 [82.53.135.12]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2ed944sm6705078f8f.13.2026.06.03.03.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 03:28:50 -0700 (PDT)
Date: Wed, 3 Jun 2026 12:28:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: Re: [PATCH] igvm: replace raw uint32_t with igvm library types
Message-ID: <aiAA40HG1Ydtw3UU@sgarzare-redhat>
References: <20260525-igvm_types-v1-1-df2907c1815a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260525-igvm_types-v1-1-df2907c1815a@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 25, 2026 at 01:56:57PM +0200, Luigi Leonardi wrote:
>Use IgvmVariableHeaderType and IgvmHeaderSection in QIGVMHandler and
>qigvm_handler() instead of plain uint32_t, so that each field's purpose
>is clear from its type.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index c347d0c17e..8bb5750768 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -102,8 +102,8 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
>                                        Error **errp);
>
> struct QIGVMHandler {
>-    uint32_t type;
>-    uint32_t section;
>+    IgvmVariableHeaderType type;
>+    IgvmHeaderSection section;
>     int (*handler)(QIgvm *ctx, const uint8_t *header_data, Error **errp);
> };
>
>@@ -132,7 +132,7 @@ static struct QIGVMHandler handlers[] = {
>       qigvm_directive_madt },
> };
>
>-static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
>+static int qigvm_handler(QIgvm *ctx, IgvmVariableHeaderType type, Error **errp)

Pre-existing, but since I was looking at the code. In all the place 
where we call qigvm_handler() we get `type` calling 
igvm_get_header_type() which returns int32_t (< 0 is an error IIUC). We 
convert to uint32_t without checking errors, maybe we can improve it.

That said, this patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> {
>     size_t handler;
>     IgvmHandle header_handle;
>
>---
>base-commit: cbf877d67a812be17a9ce404a589e1bdf722c1f6
>change-id: 20260525-igvm_types-4b24d233e6bb
>
>Best regards,
>-- 
>Luigi Leonardi <leonardi@redhat.com>
>


