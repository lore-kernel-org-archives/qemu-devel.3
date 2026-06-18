Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D168CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 18:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waH83-0006ES-QB; Thu, 18 Jun 2026 14:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waH7v-0006DV-OG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 14:06:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1waH7u-0004GN-5V
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 14:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cq4K4fxUQWoZMHVBA/HfN09drEgut7BXBhEr/ahJZqc=;
 b=DhoS40tV+xVT1lT+OkWramLxmS7L8gq5P8jKlU0pRVjNa+ZV3htLfrslS9aYSG3stAaKY6
 BFviu84naHWA46R9gThJNO91j2n15j+DbI4yEzNOk8kG9unjrLTEPMbYB/Cxat+xagVXhc
 c0RObH3w8BbGy9uBkANDMqI/3E3hRRc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-JIdZLBwoNumK7_PbAAOiBQ-1; Thu, 18 Jun 2026 14:06:02 -0400
X-MC-Unique: JIdZLBwoNumK7_PbAAOiBQ-1
X-Mimecast-MFC-AGG-ID: JIdZLBwoNumK7_PbAAOiBQ_1781805962
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b0682d2fso10657365e9.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 11:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781805961; x=1782410761; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=cq4K4fxUQWoZMHVBA/HfN09drEgut7BXBhEr/ahJZqc=;
 b=IJwlIOnRxlVP3N/C7UMx/plhXqP8Upm10VLp97vKDPDXLALfvo+lmfaf1ZdwpKyffI
 G6+9at2ROvlWP3uXGk1H3bohj04ZsANULvOJEoADE9yZ2tlVjPOnqCRhcvV0WUKEtKTa
 93kav6lf+A+v3Af2woBLim5TCw5nqZCbLvd463skfK7hOas7v9HEnQMb8/jauedvY0sH
 KLigLdkrifDdCVvIXs0xSB7DfXu76i+RI+VeWU/Liq5COWQ6LeQzMofWZBPOcMR23psZ
 G2XE2xHsSJrKAoRAfTU5V+weO14zfZezAOEnL2oYlcTgde8kuu2XpPEv0FAumSzpycwv
 tcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781805961; x=1782410761;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cq4K4fxUQWoZMHVBA/HfN09drEgut7BXBhEr/ahJZqc=;
 b=gAOPpn/YXX2olaY3IzGT4dtcfp+gjgyMZLvASKTcEkEQ7ip32gPIJNKTq99AvQUJnU
 yxEkrnWwDSso/U/6Lioz8lFu9nGHKHWu27q79R7krQ9q8PlZ04F/96TjTEURNK8wmWE/
 45L0xSnc52LtIFtSmWwK7nVXono/B5krww6wrsboZz2rU/eCkAxL4lNUJpKHpUrwZTdr
 bGh6v24x+BI9PSx50hVz7dAnQY3AXSKwy36wrsgnbLzCZULKjmoFHJhrjIP/KnAcFANm
 s1/pZJaULO/x031okJzaz06//Ix3/rU9WmNWRgBSTjuRnAYT9cnYXRVCCx0vy7upzOix
 795g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+tY+pssmVRrDfaGhjS+tSZxkWW81yj4aon2q6qME9ZeZ8xIye1Eoj+7JBYpHtem1j4S7VpkSVmdrB1@nongnu.org
X-Gm-Message-State: AOJu0YxhArbpunLAr8hyYE4+PwIJSZrT98SXW8wOeS0HqNA/WRBUqrZH
 Z1cCoOt5+Y2p6NAsNFjbfOH4M+9wnSi2JZ0GNuECba0DChHuFlj/7OPJNCC3fbJ49zomFyicOri
 kcfj0IeNQv39qljem4vk30vbb0kHqYMeztHVQguM7K21rLx/70IiWR+z1
X-Gm-Gg: AfdE7clMgWJZ6QDShZqzv5M7QwWjV+TBqoniqz7S44TKaPUsbVMhW52D20dBHrxli51
 b+QxPmeR5b0Xq2pNh4/23lCmGE+PIGerguXDKJIxrxuG1nJUsXP7P2ChMcw31XL4GqrkXfqSOyL
 D3C5XQ56AOJapg4SiDbyMlbeaiMNR1GUOTEeNmFkfax0zHf7qTfV+LHT/jPt6I8VqKSXeStvKX+
 S3kBBbyS3a2jusg+5n62VvsuC6BRVlbjSri7e53PimoOc5mqqMuxSGYRPAw3QZnTO74vvoEcBlU
 2XQf8LPcMuY36rQ9akdbhvT68xuC/MeuvzOhVkZATp6E2pqn+62wPf9N/NXKxPJpRuMTFffiPwz
 TMW9yVbA=
X-Received: by 2002:a05:600c:5588:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-4923f578dffmr7974525e9.22.1781805961703; 
 Thu, 18 Jun 2026 11:06:01 -0700 (PDT)
X-Received: by 2002:a05:600c:5588:b0:490:58ef:cea7 with SMTP id
 5b1f17b1804b1-4923f578dffmr7974165e9.22.1781805961297; 
 Thu, 18 Jun 2026 11:06:01 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.89]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fc47720sm12441445e9.0.2026.06.18.11.05.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 11:06:00 -0700 (PDT)
Message-ID: <dd2ce90e-0969-4b58-bf92-22a7a822cd10@redhat.com>
Date: Thu, 18 Jun 2026 20:05:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [qemu-web PATCH v2 0/3] switch to GitLab confidential issues for
 security disclosure
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>
References: <20260618132058.1044341-1-berrange@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260618132058.1044341-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 18/06/2026 15.20, Daniel P. Berrangé wrote:
> I previously raised the idea of using GitLab issues for security
> disclosures:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2026-05/msg04582.html
> 
> This patch proposal formalizes that into a concrete proposal:
> 
>   * qemu-security is entirely discontinued
> 
>   * "confidential" GitLab issues are to be used

Thanks, pushed now.

(if there are more refinements needed, please provide patches on top)

  Thomas


