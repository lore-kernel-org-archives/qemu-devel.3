Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3053E77173
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 18:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJGcs-0005no-47; Thu, 05 Dec 2024 13:30:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJGcr-0005ng-4Y
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:30:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJGcp-0000IX-G4
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 13:30:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733423453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0EV2Pl0XhfhPDgKftqMIgmpyNoNxcUWIgGvtN1nSogc=;
 b=XCgztBuFcUSjbuQHOa3+HgG1s6RMJdDRosNs/akw/SHq9j1d6KUog3VYPhamjyrCJkQ3EX
 xO+fA0zjGFQNZb4H/WDoSQE15PpAv8Ym1btnGQyaB0mB2mkIy9yxZy8CT05ZFmkYyPghr6
 FYm955WXuPJYrTQMcTQ6K1lGMIQ+1LI=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-lY3RFIzLMKGPdnyeFGDZow-1; Thu, 05 Dec 2024 13:30:48 -0500
X-MC-Unique: lY3RFIzLMKGPdnyeFGDZow-1
X-Mimecast-MFC-AGG-ID: lY3RFIzLMKGPdnyeFGDZow
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-3ea2fbfcb94so1083321b6e.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 10:30:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733423448; x=1734028248;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0EV2Pl0XhfhPDgKftqMIgmpyNoNxcUWIgGvtN1nSogc=;
 b=RWubO/FBnDcXV7lVX7B2WsiFhzvi2EoxTqmCkgTRPp9YgzkVoyLQM1fFtFdSLAl+6u
 lWbXpMWivXM6rMIfIZ42ySXwxjNovF6XyO2qkrr7XJiSlPK5q/2GsewoI71kPM0E0MFv
 +bFwtgVoaNT31pQpzGzIJqmCCQBEghtbUwqV4+dsXQ1i0r8Tcet7o7agQEqjGRdW/TG2
 JZy7tq49MAM3Ybw6VJs/uSIGYUkKdM44HJ0SoGLX4lsnQbhN7a4/bZqKDDaPjjshwlOC
 P3osYE7tMSkLqGldSwBhAlVKlC03LfbM8MMaBBlE0n8k7EvsP5FVtmNfm00tjMR8hUsE
 zzPw==
X-Gm-Message-State: AOJu0YygDKzykWLyJvE/OEP0nhVeFAjmezFDhhMJHZrQ4cDZwMxsnerM
 Bei8HLV2mnmi8xXGG2jcq3Sz9/Z1yP+ShQbkMvV344vGPedkTta9bhjSDKAAXyBaLgS+Axzqh1X
 nV4fgASHR2dgssSGV24dihIJk49H/1gHc3erkR+JifdEtQn/8lL/G
X-Gm-Gg: ASbGncvYPwvuJji04uQUYuhaPE9deJtsrz5F9rkyVWmLhj1zmss/xVmyh4UesIBoqDG
 lkNAN/0DJeiB38p3bmMoC9+gW1h8qdBSzd5mJeJuzj7Nz8LTO5OSNBMISnQT8mUFJOFPN/E0JoU
 2Ax6g2kpA/6hP/ZO6bI9CSJKqutp/DUmdnqBGfsZ1BtOf2SNoJ0sZS8VSza6Bt8X9sSnA92kZUF
 GlLc4edQz9FV/erDkmXcvDaADsbu1kGAk+aqOPtXYaVSKpSCj6OUUaS
X-Received: by 2002:a05:6808:e88:b0:3e6:5761:aea with SMTP id
 5614622812f47-3eae4f2d456mr14144171b6e.10.1733423447958; 
 Thu, 05 Dec 2024 10:30:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbUowyf/omcVXPrzm5frtjBkRRg4AJOqATqSbWoO+I1+y3GvLe22q5ojWMQemsIE4YCpc3Gw==
X-Received: by 2002:a05:6808:e88:b0:3e6:5761:aea with SMTP id
 5614622812f47-3eae4f2d456mr14144134b6e.10.1733423447627; 
 Thu, 05 Dec 2024 10:30:47 -0800 (PST)
Received: from [10.195.154.128] ([144.121.20.163])
 by smtp.googlemail.com with ESMTPSA id
 6a1803df08f44-6d8da9fd389sm9028976d6.79.2024.12.05.10.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 10:30:46 -0800 (PST)
Message-ID: <1f008c2a-aaf6-497d-becd-f36f5d9aea17@redhat.com>
Date: Thu, 5 Dec 2024 19:30:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 06/13] rust: add bindings for memattrs
To: Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-7-zhao1.liu@intel.com>
 <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b34733f3-1525-4e35-8c07-f84ad56b01e0@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/5/24 19:15, Richard Henderson wrote:
> On 12/5/24 00:07, Zhao Liu wrote:
>> The MemTxAttrs structure is composed of bitfield members, and bindgen is
>> unable to generate an equivalent macro definition for
>> MEMTXATTRS_UNSPECIFIED.
> 
> I'm happy to move away from bit fields to uint32_t or suchlike to enable 
> MEMTXATTRS_UNSPECIFIED be a compile-time constant.

Yeah, if we go from

typedef struct MemTxAttrs {
     unsigned int unspecified:1;
     unsigned int secure:1;
     unsigned int space:2;
     unsigned int user:1;
     unsigned int memory:1;
     unsigned int requester_id:16;
     unsigned int pid:8;
} MemTxAttrs;

to

typedef struct MemTxAttrs {
     uint8_t unspecified;
     uint8_t secure;
     uint8_t space;
     uint8_t user;
     uint8_t memory;
     uint8_t pid;
     uint16_t requester_id;
} MemTxAttrs;

is still decently packed and simplifies things a lot.  Zhao, can you 
submit that as an independent patch?

Paolo


