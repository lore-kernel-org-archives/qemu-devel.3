Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C5FF8875
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:13:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI4ix-0000os-4s; Wed, 29 Apr 2026 09:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI4iu-0000oi-6H
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:13:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wI4ir-0003Qx-4E
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 09:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777468379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uqQHFwRr6DroiTCNpDUucbHknCMRsLsW+16aQL/i05Y=;
 b=JMhTVbFYm/K4k+EtN3pdzbvjkz6hh/fcucs8QhvZRVUe6S7gUcOZSyZ4PqPooDhKSkOALc
 GJjW71sJyHfqEQ8sBIgiEUQsku/1EX8hkb6eFYCfq2S9r76TvL/udIDnB4k9Z0KiN2TOab
 K9TQSrrdAhxR4pEfDumesHn/YVVwj6E=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-290ilFsPNTKmOYvQCPlZiA-1; Wed, 29 Apr 2026 09:12:58 -0400
X-MC-Unique: 290ilFsPNTKmOYvQCPlZiA-1
X-Mimecast-MFC-AGG-ID: 290ilFsPNTKmOYvQCPlZiA_1777468377
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b249975139so223873245ad.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777468377; x=1778073177; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqQHFwRr6DroiTCNpDUucbHknCMRsLsW+16aQL/i05Y=;
 b=HbUt/VZNNU0q++gAXkcnKFqEGQlnL3ugqBz2NbygxQJujvmfGDuiv5XOEV06v0Q6rT
 +eQAYLmVmK3FJdk/jbAKkN/Nj/mdrcVggUdN8XugtER8Ur4OjM2Vh9Aqu/XIoAWGgZg3
 hSn3sqDZP79WjJQLfZVKZQNw5DMkoNClyX/xBeyfvfWWU6mqmhepFDFEUCUR0XBciHNY
 hMVFe056bbleqnCTdhY2w77kMkVHbd4RYciZqSYcsJU4M/k2l9y+kzQw5l83pfKHnoET
 1i+rVgTFqpe5IGE2F+WVmooEj3/vdFYvbyfYytUCIaAYd/AD1dUQ18xhsJ46Ei6D7ka7
 0fKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777468377; x=1778073177;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uqQHFwRr6DroiTCNpDUucbHknCMRsLsW+16aQL/i05Y=;
 b=su9jse6XT84LPsDskUE6uB194tn63jqccvFJbn/dsM4YVtbsxF1A+MdJfIuqdHQXCo
 uiYUt5PYexn5Ysk6l5vKiCSlKki6PsRIL7vhHt3BiyYQDAtjr8weB/uTB2i2itjC/PHn
 nW3FlHtz/UPI/FQObdbCbnwxO+7QvJBTNK6Z67ppZb8FnyUAhkUY9wvEItGOLTIPjARU
 VwmVL4YozgusBNslNvQKfIhj1E2SZYjX4MVdBXxyREBSEk8NxHVyHp/g1Dx1C1TK0VAW
 lM8Hk7DcKGPGXhVadRGbWQymL9+zfpP2hVu1TDPJDr0/WhCzDDvGUSW73o3lQBXKbOjX
 biOw==
X-Gm-Message-State: AOJu0Yyry2QaggS7ls8ZNvDfx9fCyViGiJFa+RFN6L5qldOZAFBaUtV/
 mD8dCoKd0xiaDvWN6jqBwxAMaUG9U2hNJiJEt0N/sDRX3JWroXRuhK+v/ruDqQBwZNhx43Hpf3X
 YVLWsSnQhroxi+n0KYqAl8JVUQWZgYvyXCefAaDgq2tFlO+L2atrAN7bK
X-Gm-Gg: AeBDiesjpkxKEDb/bF4RzFx5m0X98HzMoUeUsudh63oDjk75BZY7NoLs5HbjHcgFWHj
 Wk5Xlreo47ZK5w7GqQIbvHg+rtN9MZVyzfsfrmbxOQlJR91lhX7PsQh4Pvy7jwfwqox3amJVRii
 87DZGPnVUOz7J52lbfrRDIr/eaf2xz+5YxVlUoDIzqntqBsZRU3xZK9DE7PjnHItPPXB15nl9a4
 3gXepF3BM0vBuJsjjo4IKmdLP007TFnPX71ttVn8lyxPlr2SxaFMJBNZOkUXjjEBwRwoq1A/vT2
 npqfxzwGxCoZ9h/K4MU7EAh9OzwnrGMeijOrQJlX8W5Fy0XfJ2YMMoJ6Xm88xoSBiwzelVDarZn
 mswyy2NvatWhzr+bicjvap+M=
X-Received: by 2002:a17:902:7598:b0:2b2:5840:80c5 with SMTP id
 d9443c01a7336-2b9874d9572mr25190805ad.37.1777468377352; 
 Wed, 29 Apr 2026 06:12:57 -0700 (PDT)
X-Received: by 2002:a17:902:7598:b0:2b2:5840:80c5 with SMTP id
 d9443c01a7336-2b9874d9572mr25190525ad.37.1777468376787; 
 Wed, 29 Apr 2026 06:12:56 -0700 (PDT)
Received: from fedora ([49.36.110.142]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98897edefsm21723485ad.74.2026.04.29.06.12.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 06:12:56 -0700 (PDT)
Date: Wed, 29 Apr 2026 18:42:50 +0530
From: Arun Menon <armenon@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com
Subject: Re: [PATCH v2 3/6] tests: Convert string arrays to byte arrays
Message-ID: <afID0vZKncqbc8aY@fedora>
References: <20260429121743.1346635-1-stefanb@linux.ibm.com>
 <20260429121743.1346635-4-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429121743.1346635-4-stefanb@linux.ibm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi,

On Wed, Apr 29, 2026 at 12:17:40PM +0000, Stefan Berger wrote:
> Convert the TPM command and response string arrays to byte arrays.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  tests/qtest/tpm-tests.c | 30 ++++++++++++++++++---------
>  tests/qtest/tpm-util.c  | 45 ++++++++++++++++++++++++++---------------
>  2 files changed, 49 insertions(+), 26 deletions(-)
> 
> diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
> index 197714f8d9..8bd3288f80 100644
> --- a/tests/qtest/tpm-tests.c
> +++ b/tests/qtest/tpm-tests.c
> @@ -59,11 +59,16 @@ void tpm_test_swtpm_test(const char *src_tpm_path, tx_func *tx,
>      tpm_util_startup(s, tx);
>      tpm_util_pcrextend(s, tx);
>  
> -    static const unsigned char tpm_pcrread_resp[] =
> -        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
> -        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
> -        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
> -        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> +    static const unsigned char tpm_pcrread_resp[] = {
> +        0x80, 0x01, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00,
> +        0x00, 0x01, 0x00, 0x0b, 0x03, 0x00, 0x04, 0x00,
> +        0x00, 0x00, 0x00, 0x01, 0x00, 0x20, 0xf6, 0x85,
> +        0x98, 0xe5, 0x86, 0x8d, 0xe6, 0x8b, 0x97, 0x29,
> +        0x99, 0x60, 0xf2, 0x71, 0x7d, 0x17, 0x67, 0x89,
> +        0xa4, 0x2f, 0x9a, 0xae, 0xa8, 0xc7, 0xb7, 0xaa,
> +        0x79, 0xa8, 0x62, 0x56, 0xc1, 0xde
> +    };
>      tpm_util_pcrread(s, tx, tpm_pcrread_resp,
>                       sizeof(tpm_pcrread_resp));
>  
> @@ -105,11 +110,16 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
>      tpm_util_startup(src_qemu, tx);
>      tpm_util_pcrextend(src_qemu, tx);
>  
> -    static const unsigned char tpm_pcrread_resp[] =
> -        "\x80\x01\x00\x00\x00\x3e\x00\x00\x00\x00\x00\x00\x00\x16\x00\x00"
> -        "\x00\x01\x00\x0b\x03\x00\x04\x00\x00\x00\x00\x01\x00\x20\xf6\x85"
> -        "\x98\xe5\x86\x8d\xe6\x8b\x97\x29\x99\x60\xf2\x71\x7d\x17\x67\x89"
> -        "\xa4\x2f\x9a\xae\xa8\xc7\xb7\xaa\x79\xa8\x62\x56\xc1\xde";
> +    static const unsigned char tpm_pcrread_resp[] = {
> +        0x80, 0x01, 0x00, 0x00, 0x00, 0x3e, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x16, 0x00, 0x00,
> +        0x00, 0x01, 0x00, 0x0b, 0x03, 0x00, 0x04, 0x00,
> +        0x00, 0x00, 0x00, 0x01, 0x00, 0x20, 0xf6, 0x85,
> +        0x98, 0xe5, 0x86, 0x8d, 0xe6, 0x8b, 0x97, 0x29,
> +        0x99, 0x60, 0xf2, 0x71, 0x7d, 0x17, 0x67, 0x89,
> +        0xa4, 0x2f, 0x9a, 0xae, 0xa8, 0xc7, 0xb7, 0xaa,
> +        0x79, 0xa8, 0x62, 0x56, 0xc1, 0xde,
> +    };
>      tpm_util_pcrread(src_qemu, tx, tpm_pcrread_resp,
>                       sizeof(tpm_pcrread_resp));
>  
> diff --git a/tests/qtest/tpm-util.c b/tests/qtest/tpm-util.c
> index 2cb2dd4796..63cd5b69db 100644
> --- a/tests/qtest/tpm-util.c
> +++ b/tests/qtest/tpm-util.c
> @@ -54,10 +54,14 @@ void tpm_util_crb_transfer(QTestState *s,
>  void tpm_util_startup(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_startup[] =
> -        "\x80\x01\x00\x00\x00\x0c\x00\x00\x01\x44\x00\x00";
> -    static const unsigned char tpm_startup_resp[] =
> -        "\x80\x01\x00\x00\x00\x0a\x00\x00\x00\x00";
> +    static const unsigned char tpm_startup[] = {
> +        0x80, 0x01, 0x00, 0x00, 0x00, 0x0c, 0x00, 0x00,
> +        0x01, 0x44, 0x00, 0x00
> +    };
> +    static const unsigned char tpm_startup_resp[] = {
> +        0x80, 0x01, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00,
> +        0x00, 0x00
> +    };
>  
>      tx(s, tpm_startup, sizeof(tpm_startup), buffer, sizeof(buffer));
>  
> @@ -68,16 +72,23 @@ void tpm_util_startup(QTestState *s, tx_func *tx)
>  void tpm_util_pcrextend(QTestState *s, tx_func *tx)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_pcrextend[] =
> -        "\x80\x02\x00\x00\x00\x41\x00\x00\x01\x82\x00\x00\x00\x0a\x00\x00"
> -        "\x00\x09\x40\x00\x00\x09\x00\x00\x00\x00\x00\x00\x00\x00\x01\x00"
> -        "\x0b\x74\x65\x73\x74\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
> -        "\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
> -        "\x00";
> +    static const unsigned char tpm_pcrextend[] = {
> +        0x80, 0x02, 0x00, 0x00, 0x00, 0x41, 0x00, 0x00,
> +        0x01, 0x82, 0x00, 0x00, 0x00, 0x0a, 0x00, 0x00,
> +        0x00, 0x09, 0x40, 0x00, 0x00, 0x09, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00,
> +        0x0b, 0x74, 0x65, 0x73, 0x74, 0x00, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x00
> +    };
>  
> -    static const unsigned char tpm_pcrextend_resp[] =
> -        "\x80\x02\x00\x00\x00\x13\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00"
> -        "\x01\x00\x00";
> +    static const unsigned char tpm_pcrextend_resp[] = {
> +        0x80, 0x02, 0x00, 0x00, 0x00, 0x13, 0x00, 0x00,
> +        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
> +        0x01, 0x00, 0x00
> +    };
>  
>      tx(s, tpm_pcrextend, sizeof(tpm_pcrextend), buffer, sizeof(buffer));
>  
> @@ -89,9 +100,11 @@ void tpm_util_pcrread(QTestState *s, tx_func *tx,
>                        const unsigned char *exp_resp, size_t exp_resp_size)
>  {
>      unsigned char buffer[1024];
> -    static const unsigned char tpm_pcrread[] =
> -        "\x80\x01\x00\x00\x00\x14\x00\x00\x01\x7e\x00\x00\x00\x01\x00\x0b"
> -        "\x03\x00\x04\x00";
> +    static const unsigned char tpm_pcrread[] = {
> +        0x80, 0x01, 0x00, 0x00, 0x00, 0x14, 0x00, 0x00,
> +        0x01, 0x7e, 0x00, 0x00, 0x00, 0x01, 0x00, 0x0b,
> +        0x03, 0x00, 0x04, 0x00
> +    };
>  
>      tx(s, tpm_pcrread, sizeof(tpm_pcrread), buffer, sizeof(buffer));
>  
> -- 
> 2.43.0
>

Reviewed-by: Arun Menon <armenon@redhat.com>


Regards,
Arun Menon


