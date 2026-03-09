Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2B69EF3715
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:21:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVqn-00067P-5v; Mon, 09 Mar 2026 04:20:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzVql-00066u-8V
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzVqj-00057I-Dz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 04:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773044424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FmLlmlYhYuw/T4mShLkZVlsD4E8YWHg2lEg1DR7UflA=;
 b=BkoyFp5mSkjLCMVqTs7JCyACkCXMhDnHT0SmNXLkS8iPouO1rQtjOpTeDoYA8nZDGMNNEU
 O4YVgMKpHDMc4vi3mqIXu7+fvJGA+ET2PZmknFrK7a6F7KjLttY4+/bktyVSQLKiFE0TZu
 +rO716iAAD6RTrtpi06VI1B142lOobM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-TohGSQ5uNXyaicCkHZ5-Rw-1; Mon, 09 Mar 2026 04:20:22 -0400
X-MC-Unique: TohGSQ5uNXyaicCkHZ5-Rw-1
X-Mimecast-MFC-AGG-ID: TohGSQ5uNXyaicCkHZ5-Rw_1773044421
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439cbfcfc21so5101813f8f.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 01:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773044421; cv=none;
 d=google.com; s=arc-20240605;
 b=LgEjBv4PYFh/l+6JIGKqB/YHf4bzL0bWxUFSrAi0A5TTcpkdCvhTVePn4UmEMhbnDN
 PDZlOn6lgi1UZPNvW96/KRl49RX6gEscUaStcd2oLWPBKBTTabc3trHep2oylulNb/9E
 wJ/9UIX8DueRNdjxLxjWvXpFLDrgP4mZEdCrqkgum5T4Tn9l4HI6yGsSOiY0C4zir67s
 Xyog9gIsBH45emxJDyo/OhTXDBF6KPwCTY0FL9DZQv3MFhBwmdLa2qjsnL8aOf7aXP8X
 WiY9eXuEMDNlDMP2Yv6MvyRSt/IKtxBd2aCJIlrX5iYGLYdbL+BItlnP5r/IWWHq6cq8
 xVlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=FmLlmlYhYuw/T4mShLkZVlsD4E8YWHg2lEg1DR7UflA=;
 fh=mb0RSDKg9NKrSdKzNq2h0KYYyrAS+mWHCdBWUUuzHBQ=;
 b=U2qlIutu56g88h5mOeA4FwZ2fOHxmcU8Ne7eHrhs2hb5E5N2fOi4A2/sYqFGOUU2fj
 7tT0htTFNI/lTMW0zGgyn6ltNK03rsE5qIk3RgTaPCJH2tciY1hlSbCNoJbxU/pCnpqD
 37ONQy1nQMJYSQH73zhZHaQnwzXO6Ud94SVMsXb4rClDdo1Elrt7ZTgPKw+r5bRXMXMR
 jfPhEXFw57S0f9Vl4ydDGHL4lTC27lbxgEJ81+Q0trVsOhG27mL91zfbCT3/2MzQVGkU
 x47bz1jCLworxzxDb980QJWYJ2Rl60iMBD6y4KPXz/TcW8vhaVwSvDc35INbYTOUkwQM
 ADGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773044421; x=1773649221; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FmLlmlYhYuw/T4mShLkZVlsD4E8YWHg2lEg1DR7UflA=;
 b=jof/sVE5D3OLZtfoB0c7vIM31FYOg0VnwvcT8X4rV0p9rFHpRTbNrlC0xKSgm+u3IL
 coB7L1QOQ4kldrLLf86YDsi+jeyrmd0RuIIfYJ4+cQoSpYcUiNsbFaH2AWjiqkOUQDpB
 1Agb0++r7YGw7aO8f0xd/Atq9j3av5UvPU5aaxV2q127qogsH20EGQKoMdvBPIp6XzRN
 9ZJP7XLxRlAwxGvMqhIFhotWHSArdm2+FxMpFZC3bLl2usjhVPvG23qcZJ9GSUMUhbMc
 X40vXKYAlZTRxfcy9NHWynKVocmFWRrpwWc2px6w9owvCkiltgTdePPoZDHOyjF+x+CE
 ++6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773044421; x=1773649221;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmLlmlYhYuw/T4mShLkZVlsD4E8YWHg2lEg1DR7UflA=;
 b=DxpPNQJKJXO+CJX2EYZmo2uPyojrIeD39AlEegttb5DY2myfgpgvw5VauTmC2NrFrn
 7rIN0b6RGabRI5+BpQz9USCr/VqdOm/aytRpanHIXrD2JsEKbgIdcyuCBRQM8FvVcOIG
 796ebSIQwomEh8JMxIl5IrNStP8dpvfXxV6aFYXpHvVev/4HippknMyAjpTPUvtO1Qly
 bJOlAJ9FVOUndZWt7dg6F3luD3l8/oa+OMrxEJ9JtkesMJzTakpZOviKrjlqELXPTMXE
 HXG0tM0E5OTT3eb2bwkgNYYU6WNgE6yG7mrN8kx6AJM0AapkQhnICaxqB3pD7BCEN5tO
 zY3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR881DC3OSlJmcwqadXvUGNo9LZdZFzkHYIvXYkmYl71c8GNqH4pAMUSh2MOxeOKTX3cYbpEBwSM34@nongnu.org
X-Gm-Message-State: AOJu0YxrB5i6HG6aQVarYso6lGG2Ozs70H2kO/9ta9G7GbTo8LPWehbx
 KYpP3KTJE1ALrRiJfL6a7gnPQOoLlqaXeRJhyYi5bz+15zJAXyw8yWbM/YTtR2/KIsbZj1WwonF
 cD1qq5r3ma5RN0sXSCUJ1mGPhOOLJYDBU7lHd5gxIB+Mc7ewZK/aUmDtbuGpqyqKXlS5vuZBa/G
 hkeOKagQA7ewG8civZhxbEw/7iNhFW4Wg=
X-Gm-Gg: ATEYQzwVrxtPBDcUgj3iFR6tEBhJHNM7PpbVaC2XayRPZUuCj4Pda7TQ1S8+IsKHrCa
 4PsLwLWkIXTAVzAtlfHC0ChSkxL1nirPCd4PZ8QkyJHdCkIGCj2SO9ZXe4YMVgq82WPocSftoY9
 OR3YV9wdpXURKU8fMxrXyKkdZd5QSeDaOfNRoXsK0P9LBcD7UZMCiZrEyA3eDQ/sMdjGJTDkk95
 FeC1UtBaK+l029vwAgjVaBr996QIDtg1Rlpydz4LGTB5qCtajk7MP1IxiaER3oPn7Iu1cddpDzQ
 pXKbxkc=
X-Received: by 2002:a05:6000:2dca:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439da354a8emr19401405f8f.12.1773044421371; 
 Mon, 09 Mar 2026 01:20:21 -0700 (PDT)
X-Received: by 2002:a05:6000:2dca:b0:439:b046:2044 with SMTP id
 ffacd0b85a97d-439da354a8emr19401362f8f.12.1773044420884; Mon, 09 Mar 2026
 01:20:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260307181856.2209-1-mohamed@unpredictable.fr>
 <20260307181856.2209-3-mohamed@unpredictable.fr>
In-Reply-To: <20260307181856.2209-3-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 9 Mar 2026 09:20:09 +0100
X-Gm-Features: AaiRm527i9QEo9DghNOF5yg_dWiPZSNKtlGN03joRAyLolyXS0kg5dzXD619DRM
Message-ID: <CABgObfZqDHL=kkto8i5VdpO+mEOfeZ9vYSMmVnS+T4cwNekzzA@mail.gmail.com>
Subject: Re: [PATCH v6 2/9] meson.build: older macOS targeting compatibility
 with macOS 15.4 SDK
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Wei Liu <wei.liu@kernel.org>, Roman Bolshakov <rbolshakov@ddn.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Pedro Barbuda <pbarbuda@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 3/7/26 19:18, Mohamed Mediouni wrote:
> Using strchrnul eagerly results in a failure to compile when using the newest SDKs, with:
>
> error: 'strchrnul' is only available on macOS 15.4 or newer [-Werror,-Wunguarded-availability-new]
>
> Working around that by not using strchrnul when targeting macOS.
>
> This didn't show up on the CI because it used the macOS 15.1 SDK instead of a macOS 15.4 SDK or later.
>
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   meson.build | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 7b4e5bc72b..78bde0611b 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -2646,7 +2646,12 @@ config_host_data.set('HAVE_COPY_FILE_RANGE', cc.has_function('copy_file_range'))
>   config_host_data.set('HAVE_GETIFADDRS', cc.has_function('getifaddrs'))
>   config_host_data.set('HAVE_GLIB_WITH_SLICE_ALLOCATOR', glib_has_gslice)
>   config_host_data.set('HAVE_OPENPTY', cc.has_function('openpty', dependencies: util))
> -config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
> +
> +# strchrnul was introduced in macOS 15.4.
> +# Keep this condition for compatibility of new macOS SDKs with older releases.
> +if host_os != 'darwin'
> +  config_host_data.set('HAVE_STRCHRNUL', cc.has_function('strchrnul', prefix: osdep_prefix))
> +endif

Is -Wunguarded-availability-new enabled by default?  If it is enough to
shut up the compiler maybe you can add a -mmacosx-version-min= flag, but
workarounds on each function are not acceptable.

I'm applying the other patches, but for this one I don't think this is
the right fix.


Paolo


