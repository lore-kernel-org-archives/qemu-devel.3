Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B80CC6B3A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:50:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHLqU-0002EQ-7k; Thu, 15 Oct 2026 09:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xHLqN-00027G-87
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:50:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1xHLqK-0000YM-R6
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 09:50:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792072198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3xSUqvaYHeIl7LVURifPRhqq2/FMemYsmD1J0Gnhx2c=;
 b=UnFO++SzQKrwQHHn7xigwU+p/xZ5jVEdTz9Z8bsc6DgfDrlUZE7X3EsTgx4tPcpgNdNJ1Z
 cUlxPZDnNg69cPNbrEg3lUiaYMjXb45zbSccxxvznCeaptYoUwP92aB+I2wyX16Mc8/W+m
 N+6rPOquVyTll7/jJJSjqWXcaPwtSxM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-F9scjaqSPBaCIYTjLNcoWA-1; Thu, 15 Oct 2026 13:49:56 +0000
X-MC-Unique: F9scjaqSPBaCIYTjLNcoWA-1
X-Mimecast-MFC-AGG-ID: F9scjaqSPBaCIYTjLNcoWA_1792072196
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6b1e4a24fe5so2929295a12.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 06:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792072195; x=1792676995; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3xSUqvaYHeIl7LVURifPRhqq2/FMemYsmD1J0Gnhx2c=;
 b=fhdVzDuxIsnfS3QnlcuBd2Cm8D6FjIG5GMdpM8xsAJiQ1x6nRrb8AtpCI7xSdSMryN
 hbjieNkZuzkdt0yTB8yp58V3dM5M7VdUaA8qw3HSQNxpYlCAhrQleHvIEormc+NSWooj
 W3jwqWRhbUUHajDrLePIBqggEnpWUscRw8IA5M9X6pJuiR4VzanPAZghXvtS50tkS6ft
 XyekvNwN12s84f1fFNm1KkAhO9N2yoHnmbR1oIkisgVSBUMlbEMpCI7hA4Z95zoOS+/Y
 vWsl8whnvlSi5Iypr7CG2KTxxVv6puKPHPgaRxGplF3CrNQLq0eh2ZrBXftYiJBjNB38
 kg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792072195; x=1792676995;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3xSUqvaYHeIl7LVURifPRhqq2/FMemYsmD1J0Gnhx2c=;
 b=xYcrJCPEdldF2boHPlCcSCeLZaJjvDVE+Io4FO89WX+aVxKIHcHqCj53Wm4d+ZR16J
 uJeZD8HfKCd4eL2tD4trzbXBOH1GzUystiCwl0LrVgfEaLS/gb/s85Bnpm2JmebaFDa6
 q73jKYCMHlvxy6K2UZw9gMeaayL3HQX7paRmfJDzdayiwjsRMVjdV/JtK4FmXJ+P2cj8
 /RFCrH7MMjTH46hciZlrY2DLUIONkDNBM9uc/kseis74da5h/lrBr4sMCc5+4zgn1vda
 qFBjnvdORd9sY1m1J1tXecO+fbXAHFtYgabl/nWLYVh71ziSLWiPFbEwwtkx+kaZubOs
 hmHw==
X-Gm-Message-State: AFq9FYKgTefjUNJOX3nYxaMNfBovL9e3mzZqR1Xr4CFj4B/vg66mTnAx
 rKTzYIenEp2paQt2WvtZBMYjRLsoMU0FrOw3TZNet+MBq3tzDEmhDFicfow8uiqY2E9oQmIZEQs
 SBLeAuD+yKURlpXutRpEGgTKJfHwGAjqwG5ANzwMcBpX7u2yFiedJwxZ6
X-Gm-Gg: AYBFou0oi48E69BdlQ2mChQSd5TliKTd0M+TzolyHEw35HNLTnbKBuzh7tmdoqCuM8L
 hO8yKBhbfPe/ZJPAKOO2PbYjZK37lpRcDal1ewT7M4Fplb+r9ufIGiO6ynEnrmFCuZTDQQlIKzA
 oyCsqEf1NiIxV2ilcVvSd2Y51wFesbrIne5w7Yjat4sia3xkdVBZbWYbXjj2UKZ4zYDFvh9Ns6z
 AozK3AFpRN7MxPG2oU+kDtJb0beWO/6DEl3KlKZ/xMmW761dWFCA8inRX1s51oXytjCpq/gqXvA
 i42O8zO4gx7fmQmwUoZXHB8oXxITO7QIlsj4SgYkCxWOHA7X5YuRfkffJDtsaks5SB3uP3LtNDj
 1wW39SA==
X-Received: by 2002:a05:6402:1ed4:b0:6b1:ba86:5f55 with SMTP id
 4fb4d7f45d1cf-6b1ba86636dmr10573425a12.35.1792072195347; 
 Thu, 15 Oct 2026 06:49:55 -0700 (PDT)
X-Received: by 2002:a05:6402:1ed4:b0:6b1:ba86:5f55 with SMTP id
 4fb4d7f45d1cf-6b1ba86636dmr10573393a12.35.1792072194687; 
 Thu, 15 Oct 2026 06:49:54 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.147.123])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b203839ca1sm2617292a12.11.2026.10.15.06.49.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 06:49:52 -0700 (PDT)
Date: Thu, 15 Oct 2026 15:49:45 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2] igvm: add command line parameter support
Message-ID: <atDVonnkX0i0xzDY@sgarzare-redhat>
References: <20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Thu, Oct 15, 2026 at 12:41:57PM +0200, Luigi Leonardi wrote:
>Add a "cmdline" property to the igvm-cfg object and a handler for the
>IGVM_VHT_COMMAND_LINE directive, which copies the string into the
>parameter area the directive points at.

Should we update docs/system/igvm.rst ?

Maybe in another commit, since I guess we forgot to update it also for 
other directives like IGVM_VHT_MADT or IGVM_VHT_DEVICE_TREE.

>
>The command line is passed to whatever software the IGVM file loads,
>such as an SVSM. For example, SVSM can use it to select the serial port
>it logs to.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
>Changes in v2:
>- Updated commit message and doc to make it clear that QEMU does not
>  need to parse this string [Markus]
>- Link to v1: https://lore.kernel.org/qemu-devel/20260930-igvm_command_line-v1-1-62857007d89d@redhat.com
>---
> backends/igvm-cfg.c            | 21 +++++++++++++++++++++
> backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
> include/system/igvm-internal.h |  5 +++++
> qapi/qom.json                  |  6 +++++-
> 4 files changed, 62 insertions(+), 1 deletion(-)
>
>diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
>index 935ba54f54..ec796ea8a6 100644
>--- a/backends/igvm-cfg.c
>+++ b/backends/igvm-cfg.c
>@@ -34,6 +34,19 @@ static void set_igvm(Object *obj, const char *value, Error **errp)
>     igvm->filename = g_strdup(value);
> }
>
>+static char *get_cmdline(Object *obj, Error **errp)
>+{
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+    return g_strdup(igvm->cmdline);
>+}
>+
>+static void set_cmdline(Object *obj, const char *value, Error **errp)
>+{
>+    IgvmCfg *igvm = IGVM_CFG(obj);
>+    g_free(igvm->cmdline);
>+    igvm->cmdline = g_strdup(value);
>+}
>+
> static ResettableState *igvm_reset_state(Object *obj)
> {
>     IgvmCfg *igvm = IGVM_CFG(obj);
>@@ -85,6 +98,13 @@ static void igvm_cfg_class_init(ObjectClass *oc, const void *data)
>     object_class_property_set_description(oc, "file",
>                                           "Set the IGVM filename to use");
>
>+    object_class_property_add_str(oc, "cmdline", get_cmdline, set_cmdline);

Should we add this to qemu-options.hx as well?

>+    object_class_property_set_description(oc, "cmdline",
>+                                          "Set the kernel-style command line "

nit: I'd remove "kernel-style", since it's an implementation detail but 
the format is really up to the guest code IIUC.

Maybe we can reuse something similar to what we have in libigvm:

   /**
    * A parameter which describes a null terminated ASCII command line to
    * be used with the guest as specified by [`IGVM_VHS_PARAMETER`]. The
    * format of the command line is specific to the guest being loaded.
    *
    * For example, this parameter could be used to describe the Linux
    * kernel command line.
    *
    * In the [`IgvmVariableHeaderType::IGVM_VHT_DEVICE_TREE`] parameter,
    * this corresponds to the `/chosen/bootargs` field.
    */
   IGVM_VHT_COMMAND_LINE = 782,

The rest LTGM,
Stefano


