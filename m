Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA16CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:15:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0iFv-0002TH-Sr; Mon, 22 Sep 2025 11:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iFh-0002QN-H9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:14:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0iFf-00076O-F6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758554090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZsOhKk8k8zWF25JRFopz+bPQRcwt4sLF2X+7ZhvlSHc=;
 b=BRE5V49V4ApIPbAlQoH+mBJUlKtzgL8z4UJQd46h5TdNhzNiGu9CkpGHnClVNiqifa41us
 r0U8KZlx/Q1DPEt8BYjQmVQtybr/IOeXTVrQQLXic78fMmSjCfY67WbHqPKM+QACYMZax5
 0xu9z/4gVBc//pjAqPAtrviUS3sT3fg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-30j3VO7RNJKPTfaZAfoCOw-1; Mon, 22 Sep 2025 11:14:48 -0400
X-MC-Unique: 30j3VO7RNJKPTfaZAfoCOw-1
X-Mimecast-MFC-AGG-ID: 30j3VO7RNJKPTfaZAfoCOw_1758554087
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ee888281c3so1097916f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758554087; x=1759158887;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZsOhKk8k8zWF25JRFopz+bPQRcwt4sLF2X+7ZhvlSHc=;
 b=if0wajfQbMqRQDQkJ9KQ+e8McwZKWoVpPu7Ra2dLtSXZHo9IS+iIuQ8HPDM1pzLD7y
 qCotjXEbVHyJ7b5mcxUOMr/WP6a+vjjy8k//pCRjpNlsPtVmiBQqScGtq46+OoPPjb29
 MsmqQktQHvJrAzu6ndp5s0wJ8NnZ40EFBWG50MktnLeTWyDlY21idFue6oibMcRJsLaM
 P6WSIT6yULeP/hBnIElfpVBBAe6WmhCHPKkKPtzGW7j8/ixg+F5m9fLlqhH99TiT18oE
 fPHrMYHVCmVxHr4ksEXP8pZ/hpy+SsV9InAF7W2bxyEMjG99tMDtI0lmBYGtKsTuiUqi
 yYYQ==
X-Gm-Message-State: AOJu0Yz1TlNaST7TYqyTTLnhEwWpZOZnDjZlmEhCqK//k6b1kZxhWPqH
 eFKhKJ4ed4Pzmpj91uwLYB5FqYD/EAkw0wWh78hpHnBW2dxACxXLkcgQaQH53YKbtQLP3xY/XoM
 4W2KaalLRe/2ffglg5P0nYwhTyiSGAeOLYKiwbb9UeKWeeM1ycpYQO261
X-Gm-Gg: ASbGncsgnc4RJm27py06zH9Wg4LI3/HCn9IUJYWJaU+7C3UbVdzLvi22pAtz7QvW+6r
 B0aOXOKjeqxSC+SRgWtnXVzCpiJeehnlxNi0HH2RkNYfcBpRsDupoqm/L5uTiIKMg039HGqSXr0
 TTKda3+1qK/A4kVwSZQ6h1FBbrgZjE4C2WAgVLMW65S4WpE7e84H2d1btYr22dMdXe0OWSTDNF1
 PxQObMunAg+HICmSHl6bGrI6FfFt2bkVmK7Gqo3KGBBzD3/MKcOoNr7HeSKvVl0qb+ZHpVz99iQ
 KTCfn2/5V/LT0EDpRfP714PF3a1IygcE5KyNupHlsWtaOhB8nyfbJPOSp65sRWuWRCr1ghCbXVE
 Xw/HE41y8Sl2+L3GpQUcHjVyDkYXC7J2eoR1mzvXNtYs=
X-Received: by 2002:a05:6000:2689:b0:3ee:1125:fb61 with SMTP id
 ffacd0b85a97d-3ee7c5529a4mr11780140f8f.7.1758554087181; 
 Mon, 22 Sep 2025 08:14:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCB42iFW9uq7DmdTQIrfHIuLUMYTeKMVmBQ50sdvrJP7igiIqVuOhfrJhLj45HwHC6EIHxzA==
X-Received: by 2002:a05:6000:2689:b0:3ee:1125:fb61 with SMTP id
 ffacd0b85a97d-3ee7c5529a4mr11780124f8f.7.1758554086820; 
 Mon, 22 Sep 2025 08:14:46 -0700 (PDT)
Received: from [192.168.10.81] ([151.95.47.123])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-464f5a2850csm205261285e9.19.2025.09.22.08.14.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 08:14:46 -0700 (PDT)
Message-ID: <d4c96f37-0a72-47be-b736-6d4c50f74b10@redhat.com>
Date: Mon, 22 Sep 2025 17:14:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 21/61] configure: bump Meson to 1.9.0 for use with Rust
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20250913080943.11710-1-pbonzini@redhat.com>
 <20250913080943.11710-22-pbonzini@redhat.com>
 <CAFEAcA9QA5WZnk0R2ZYg4rraX_+1LdRjfo7Ybb6MQkrBuaRt3A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA9QA5WZnk0R2ZYg4rraX_+1LdRjfo7Ybb6MQkrBuaRt3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 9/22/25 16:07, Peter Maydell wrote:
> On Sat, 13 Sept 2025 at 09:15, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> Meson 1.9.0 provides mixed linking of Rust and C objects.  As a side effect,
>> this also allows adding dependencies with "sources: ..." files to Rust crates
>> that use structured_sources().
>>
>> It can also clean up up the meson.build files for Rust noticeably, but due
>> to an issue with doctests (see https://github.com/mesonbuild/meson/pull/14973)
>> that will have to wait for 1.9.1.
> 
> 
> It looks like this new version of meson now creates a
> subprojects/.wraplock file which shows up in "git status"
> output. Should this be listed in .gitignore ?

Yes, there is already a patch for this on the list.

Paolo


