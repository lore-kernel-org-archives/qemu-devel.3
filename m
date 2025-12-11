Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9271D41C14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 09:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTdCR-0007gf-3Z; Thu, 11 Dec 2025 04:43:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTdCP-0007gV-TQ
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:43:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTdCO-0005fY-7Q
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 04:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765446179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=5/6uA/3wOUHJdk91kbUDLu249x2jP1J/9xVRDtTz+9M=;
 b=amazfd874iZldPdMhGv7pH84+5AFUldWdbU1y1dRWvqvx7tpZhaIrqKzqGhCMcV/3jRHX+
 c5QNy48sIJ3KUqB8QH+MYPdf7iQUEJ0AUZohFicyjsvRweD6oWdLjsxFPMHNx+QsAX6zOR
 K7ZGiPAjWPYjAhUAQZEQ8j2RAdkUrxw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-I94xRJBcNbWOYtILqb4CFg-1; Thu, 11 Dec 2025 04:42:57 -0500
X-MC-Unique: I94xRJBcNbWOYtILqb4CFg-1
X-Mimecast-MFC-AGG-ID: I94xRJBcNbWOYtILqb4CFg_1765446176
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6416581521eso928983a12.2
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 01:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765446176; x=1766050976; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5/6uA/3wOUHJdk91kbUDLu249x2jP1J/9xVRDtTz+9M=;
 b=YzFDqy38FqxQcDEvFKOljCU6yjVTSCBfLL6Y251AD6ED8BWRzlpgZlOXQd+Uqas1Kn
 sLTwcPviyyFz5GgrKlvi3Wh4yIin0sjHGbxeuOFpw/ZRGKFJmXWgVoN5R5PUMpQHe+mh
 usBs7CzWOJMYzbF4jP7Fvrrqag5ARp/VKMk01gny/QxRYpZzYU5iS8JMytv7kmZUHGdt
 r4ObwTUBTAVdK6gjpoovLaZu2qGGMUkrZuS/5K6IoEcWswjwfBgSN64INHyNpR9QEWeI
 iuzBcKIJdkkyWMXlLcospY6e7iHXO20k3J4XHAwmzo01QVeKhjhJ7qiypeg4iMhXn9yK
 dmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765446176; x=1766050976;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5/6uA/3wOUHJdk91kbUDLu249x2jP1J/9xVRDtTz+9M=;
 b=hm4ChurSDM1ciJst+3xUtiU7Ht/llrnWe+RgFniagX45IwOBIcjh8A0fu16KmYYopf
 uLfXPn9WdfcWHJrvVk+wC/Kdwxh/TAhcDUjEoFVvm2NsVZsdeMUdjuwF1cvCABxgT1S/
 yFerxPMdelboO0pjgMfGOF3k1f3otkyH4Kb6jJbWrREcZNhE8KdatnWBjX/I4RwBfn0S
 yPHhqp0aHZU4ijYmJTa/ZgbWmK4SpDWzg7YYxkyBRdHBv3ftFOr3ygYK7Hm3nM5Sf6Rn
 /fw+g5VBTNe3vZgxIw4ahkTEceSxiZ5RcRJpgdWF0Aq4RV54hk8Vf43ekAh/F7GNEXkR
 tbOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3+tzXT6TU/ZaC1uvC4r35SUjzGoS0zENOEUWP9eNxUTTb2vwcp/Gs0K4d3VHW2e4K68psK0Luj/cr@nongnu.org
X-Gm-Message-State: AOJu0YyoCP5FtjobfIhPnQoZueJZHPKlm+SwZcQ+ZGVo5LVFIacZVNQU
 pz7KFMaToG/2b/kBp4Q01kSJiB4tIlF74HLXsyYT6dV7v8CjuKu/5Pz1aIWBNXNSiEwfFlyZTBl
 oKY07KoPZrx5moVPUUyTBCX4ycHesxZzCA5DaIeU7jiqDpa+xKgjsXFyR
X-Gm-Gg: AY/fxX5c1JDoFvcoxTtr/Uv/HxttSkLJLsqFy1kkKRBRcOIjar2KW6qCRsDdpbNQzy5
 mQakVte8aeF0V3RaVFONoX1U88rUeqeVXVBdIV2UGtcnwa5OhKsjKO12BuXd4t5NkRe+tJtbFQE
 CmJMIxs+Z/qOnyXftxrPbnPWTZhuU93EXyc0DH1d8LIlRuFTSxU1gIZ1+9kIs/ROklEL4hoo29I
 EsAsSwChd3+FWBgeoPkqZY+fyl4AJQXdoXqFE6BGYL6CVX0zNyEZijcqQiGVvnG6QQp2i6VTV8V
 EJSy9Fp/SwWA9ChTAow/BFcpYM+hqE6VNgVb0Jv7IImHcLeJT1gD5jaC9fiwcmURkXrTUunsfDa
 TG9Rk3GHec+1bXHI5xbKYDr4Gj3Nm4sVb0SZu1dTV9as9zX/jZbMFR+qzaJ2vYQk93pFYZ3K65N
 PnbSZArxkE/iR/R80=
X-Received: by 2002:a05:6402:234e:b0:640:f1ea:8d1b with SMTP id
 4fb4d7f45d1cf-6496cbc43eamr5203524a12.16.1765446176301; 
 Thu, 11 Dec 2025 01:42:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkqB0lOqTTY//ENdRxS0fIqXz+u8gEeyxDFPsZWUiU+o3HppiGYVaD75VpZdrK94jlixVxSA==
X-Received: by 2002:a05:6402:234e:b0:640:f1ea:8d1b with SMTP id
 4fb4d7f45d1cf-6496cbc43eamr5203506a12.16.1765446175919; 
 Thu, 11 Dec 2025 01:42:55 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-649820516desm1993624a12.14.2025.12.11.01.42.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Dec 2025 01:42:55 -0800 (PST)
Message-ID: <df96afb2-f99c-48ae-81be-ccadf0fc3496@redhat.com>
Date: Thu, 11 Dec 2025 10:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] i386/cpu: Support APX for KVM
To: Zhao Liu <zhao1.liu@intel.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>,
 Xudong Hao <xudong.hao@intel.com>
References: <20251211070942.3612547-1-zhao1.liu@intel.com>
 <16e0fc49-0cdf-4e54-b692-5f58e18c747b@redhat.com>
 <aTqMBtkOxx6mZhn+@intel.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <aTqMBtkOxx6mZhn+@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 12/11/25 10:16, Zhao Liu wrote:
> On Thu, Dec 11, 2025 at 09:08:33AM +0100, Paolo Bonzini wrote:
>> Great, thanks!  Just one question, should the CPUID feature be "apx" or
>> "apxf" (and therefore CPUID_7_1_EDX_APXF)?  I can fix that myself of course.
> 
> Good point! I didn't realize this.
> 
> 1) Per APX spec:
> 
> (APX adds) CPUID Enumeration for APX_F (APX Foundation).
> 
> 2) And gcc also use apx_f:
> 
> https://codebrowser.dev/gcc/gcc/config/i386/cpuid.h.html#_M/bit_APX_F
> 
> 3) ...and we already have "avx512f".
> 
> So you're right, I should use "apxf" and CPUID_7_1_EDX_APXF.
> 
> Since APX CPUID appears in several patches, I can respin a new version
> quickly.

No problem, I have done a quick pass with "sed" on the patches and 
reapplied them.  I do ask you to respin the Diamond Rapids series 
though, on top of the for-upstream tag of 
https://gitlab.com/bonzini/qemu (currently going through CI).

Applied for 11.0!

Paolo


