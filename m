Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9D7E64002
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 18:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEBk8-0003Ph-ON; Thu, 21 Nov 2024 13:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEBk6-0003PV-5s
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:17:26 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tEBk4-0005wR-Gl
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 13:17:25 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2eade1cad26so1073729a91.2
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 10:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732213041; x=1732817841; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aG4iovgG9c+atXmTIJ+CAyargz2qD4lIsQ36k1DaHLk=;
 b=zxdOe7+0m4voV6D8sfr3tvVraitpIEREOXegUW/l1a+JVuS4gZP+/EAV6ATZXaZp3Q
 Nl+yMMJPDXTMJ/8S/E2ELisI1SFRVXQaNFdopwWszxKR0LsHxA5cn1hsZ0/LR8SXT0a0
 gI6Hz/8nf3DAK4fj4s9OKIWfYy+kyTgAycl2buaVVVe7fpxDi2NgEyh/Mr34LbPkXT5A
 vaI5k7fo8U3YMr9KzpCAW6jW28M4/mkokvcnojqo0C4taLPO8vprQXXxYKnMKsikFi4z
 kObQEeNiJoRcv1Oh0EDpoPgRMst7twC6b7HJ9FGYE012D9r/iUb/4S7vG8ZHOMzopBIo
 ovLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732213041; x=1732817841;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aG4iovgG9c+atXmTIJ+CAyargz2qD4lIsQ36k1DaHLk=;
 b=Zn7wMlPqcHaMHFQBaSNq4izT7JJntn4MIlSJlhaKrMZ6pPyPaVypO0SnlkB2jatxvt
 OUo+GcvqiiMUPeZg8xGy7k1mRrfZl0yUnzsVP0uSZUNOcSeil4CiNDSHIta4Ao6ktzs3
 CyTBp8AR04DsMruLFHYZ0aVH1+aXE6AVdfBoGl2KD1lBZ2rKAU089yBmaK4/MEcvJzPR
 GHz0RAmZGD2gpx5Ygm+i4w2ylc/IW7dl/8jqB6kCPXb2PsLddAQJBPhx7qFV7L4r2cpt
 tE3HMp4nzDaKhHDFu8YsC5kUBb4ahyKykRrvgUpzpLKA7Vx5sRzGYwFxBdq9ldhfuX27
 ue7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo8smKyve7gS/er+ARvVTIGWwcNkx06/6HsfobSTqPDFMuy4u/aafmegy+QjZV4TfUmpjDY/SdYN/y@nongnu.org
X-Gm-Message-State: AOJu0Yzduo42a3rXrbTsrto09vxcJ2V37U14C3ag7NEejLRGchHAnFOk
 PMbfhtLcl7HMYTertSSaLJ7LDf+k17EKZvrqmJpZXuRRlLevuCgElwxiQd/wEbk=
X-Gm-Gg: ASbGncsnxmabk7R5QdjS0ZKhnAYAAG3n691zERlnHe8CbWEq1J4ffC+3TlocsPtrBv/
 MqJRxzRhRVvUAglYzszQH5s+JbvAmbZl4sQzIwG85CWQ6aRGcUZSNAiTFluWuRhU7ut6wYfFfEw
 8SsSaCTU6wWXBe62fBDs21PTt+iv9YaEJjj1eu4nUP7ylvAHSJ24bgdFtuGfNTlI+4skOCIDA+0
 FTm5skqKhLh0wNdaZOVUoYialbZS7WDv3dTKncpzI8ntKAWsygv1SQiLjzL89Bq6qj8kQKS3aof
 IJS9iufEvEyU2CD1JCLj+g==
X-Google-Smtp-Source: AGHT+IGkOlc5EoTvlkLVuCyo8/P2z4Z/N0PL7/KevQZLCskkCtT/YvviznGduhdBzbqtkhuwlzgQNg==
X-Received: by 2002:a17:90b:1d0b:b0:2ea:3f34:f19e with SMTP id
 98e67ed59e1d1-2eaca7cead5mr8634987a91.27.1732213040700; 
 Thu, 21 Nov 2024 10:17:20 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2129dc1691dsm1227195ad.217.2024.11.21.10.17.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Nov 2024 10:17:20 -0800 (PST)
Message-ID: <61ca5164-3d81-4e2c-b581-304cf3cdecc0@linaro.org>
Date: Thu, 21 Nov 2024 10:17:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QEMU patches for native windows support through clang-cl
To: Erwin Jansen <jansene@google.com>,
 Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, sw@weilnetz.de,
 lvivier@redhat.com, pbonzini@redhat.com, Patrick Leis <venture@google.com>,
 Nabih Estefan <nabihestefan@google.com>, Danny Rosen
 <dannyrosen@google.com>, JP Cottin <jpcottin@google.com>,
 berrange@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Erwin,

I'm adding also Peter and Alex, and the qemu developer mailing list.

Regards,
Pierrick

On 11/21/24 09:36, Erwin Jansen wrote:
> The Android Emulator team has successfully ported QEMU 8 to compile with 
> clang-cl, enabling Windows compilation and better integration with the 
> Microsoft ecosystem. This involved:
> 
>   * Replacing shell scripts with Python for enhanced Windows compatibility.
>   * Implementing fixes within existing scripts.
>   * Introducing a small set of header stubs and a series of compilation
>     fixes.
> 
> We would like to gauge the QEMU community's interest in these changes 
> and, if there is interest, discuss the best way to upstream them.
> 
> Kind regards,
> 
> Erwin.
> 


