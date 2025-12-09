Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFA8D3B7EA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 15:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSzY4-0000mx-4k; Tue, 09 Dec 2025 10:22:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzXw-0000k0-EN
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:22:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vSzXu-0000rL-MF
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 10:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765293753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=prjjcyIyzqio7yIqWQyZx8iQnyWgjrBln/s93FsaGM8=;
 b=SijjW9tkb/vADrzMEGvKhNLPhcgrF7HkBs3SqETbMf0ZVCHlS1Gnh5kDKHlIxy6WY+PbNu
 9SCucl1sCySwRD2wJ15W6VOuKUw5E3PIEkwVdHWeIAui9mukzDhkE8lvX4/qXUVkXfm/8S
 LJIeLkGfmQVfTOpC86oS/gWqAaz+/0M=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-w4hhS24LM7GLARajDJQaEg-1; Tue, 09 Dec 2025 10:22:31 -0500
X-MC-Unique: w4hhS24LM7GLARajDJQaEg-1
X-Mimecast-MFC-AGG-ID: w4hhS24LM7GLARajDJQaEg_1765293750
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-477cabba65dso31862765e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 07:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765293750; x=1765898550; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=prjjcyIyzqio7yIqWQyZx8iQnyWgjrBln/s93FsaGM8=;
 b=MVkLoAlfg/mxHyALBIsglZZyGzzkJpp8CvJqk1CPbVOaazZWsNXYZ10QvXdnOIA41u
 UJEaRxBAnn7iE300m7US2Vdl5c/toZngRBKADSCrj+EuUmlY1EC1MDViUool0NYUwz0d
 imCvmgS5riuU8I/z8Iconqk0C3rhQ3tIdzFK97osO+yglFh62rZ+viRFVIZ4BbDhO8Cd
 2SSZ/sgB2BtRTCMPsL5uYX2ssqfMQN5tB1B7g0536NhQwvIpFJbuKEkbXJGEjV+ncz3+
 KXEnaZZyXmCUTJ1sZMvojDMWMd21J/HTDePIOS9Kk3Y9E54ctSUigG8AfCnU5Rkl7+5o
 34Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765293750; x=1765898550;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=prjjcyIyzqio7yIqWQyZx8iQnyWgjrBln/s93FsaGM8=;
 b=JxoCEaZtAaIHWl+czvHRWuhateiLKRpicQk8oLHvBdZK/DNyydD4wLijjzo+eaHa6j
 KHj6Cwj8wyLq+atzd1UQ335Qae3/D+oiNzU5EAeasvEm/NEt4mDLH06qTaRvFiGeV92c
 hK8zkj33/pk9/uIfSc8I/+jUXeAc0TVKr8R0N9eo5sifuzRZGryxwi7bfY3YSeSkJyhG
 XJDC9MX9RMO12x1FguQOmOc0OjYCYKm71WzdEgdiLC5PTGdpoVfAYZlgDaFiMMY2sHCy
 JRmosDGBDBvfhmk885C0s/OvxzMHpeFiNHfSQdS+cTyxRH0y5LdVLZSQMCdDX24AJcEJ
 cTKA==
X-Gm-Message-State: AOJu0Yy6IEJ2ZqLFXF+IYnGLdqe+1epvTfq+hWe2K/6koq4mFl0weJj2
 a4XRwCqEfjuslMYHJLjbNk9ha5geu4QIkkwFJa4PFQFwmxNkf7579mVlZJIafzEQhIUWDZ8HiiM
 kfbM4T6I/vghBtZoRT/WRGuqNM30KsWQCdlRjuX/531ju1ZdS7NjR8bTC
X-Gm-Gg: ASbGncuRCVv0VDxGH1PQxEP8rgVuPDrPfF6gsG60mPQg1Nae/mo1DaRQuom2W47nbiA
 7lXV8BE12ZI6pxHXR8k/xRG6pLvflD12rWHUYZkGajQFkhagPG6/QmvZuwTC0vYtgRltJIKSFp1
 wwgNGWOvwLWjABFXZLsUb/m7OgtOeh2QSgi8lVoVXdPRe41wKL8KRzjIgOnb7SbpnAbSLKo+/jL
 LnzjM+TuX/jIP1Wi3RDL0fhtNxlS++jf2ygQIpJLLxYK+S3KFu760+a9KV38hZ60TpMlip9vQ7r
 YAO9CvBAJcmU5n/7w6WIQM6YfQ42zF3OezF8YNK4sYlPWeIeoaByL8H7iq8QJIj30PW1SwV9p37
 VrVRhunsEmnZbDh9RyZchDdXijYy6XjGSKs9n4Pshc2hTXMVj
X-Received: by 2002:a05:600c:35c6:b0:477:75eb:a643 with SMTP id
 5b1f17b1804b1-47939df1301mr113413345e9.4.1765293749969; 
 Tue, 09 Dec 2025 07:22:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE7Rg1n9duDcu4rZiCY94Lph0yIuNk2AxZ0HTh5eGWO209LK+PWIx2mxZQjWvO2LfG+tFk2OQ==
X-Received: by 2002:a05:600c:35c6:b0:477:75eb:a643 with SMTP id
 5b1f17b1804b1-47939df1301mr113413055e9.4.1765293749579; 
 Tue, 09 Dec 2025 07:22:29 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d357820sm20006015e9.2.2025.12.09.07.22.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Dec 2025 07:22:28 -0800 (PST)
Message-ID: <3045e225-07b5-4a97-b56a-24e34211db7a@redhat.com>
Date: Tue, 9 Dec 2025 16:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] log: Fix result of strstr to 'const char *'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20251209150346.650473-1-clg@redhat.com>
 <CAFEAcA_q9LJAWu5wL4AosoHJqVLpnU6PDmJPj4U3Zfy1jh1F7w@mail.gmail.com>
 <aTg-X4fIEr43XI9u@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aTg-X4fIEr43XI9u@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 12/9/25 16:21, Daniel P. Berrangé wrote:
> On Tue, Dec 09, 2025 at 03:07:04PM +0000, Peter Maydell wrote:
>> On Tue, 9 Dec 2025 at 15:04, Cédric Le Goater <clg@redhat.com> wrote:
>>>
>>> Assigning the result of strstr() to a 'char *' is unsafe since
>>> strstr() returns a pointer into the original string which is a
>>> read-only 'const char *' string. Newer compilers
>>
>> Which ones? Or does this depend on how the libc headers have
>> marked up the strstr() prototype?
> 
> I don't believe it is compiler related, rather this is an
> ehancement in glibc 2.42.9000 / git master
> 
>    https://sourceware.org/git/?p=glibc.git;a=commit;h=cd748a63ab1a7ae846175c532a3daab341c62690
> 
> AFAICT it should work with any gcc we have
> 
> Although the commit talks about C23, we get it regardless as we have
> _GNU_SOURCE defined.

yes. glibc 2.42.9000 has :


+# if __GLIBC_USE (ISOC23) && defined __glibc_const_generic && !defined _LIBC
+#  define strstr(HAYSTACK, NEEDLE)			\
+  __glibc_const_generic (HAYSTACK, const char *,	\
+			 strstr (HAYSTACK, NEEDLE))
+# endif


C.


