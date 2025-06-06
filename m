Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB50FC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 11:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNVI8-0007GH-Hs; Fri, 06 Jun 2025 07:31:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNVI3-0007Fs-Mr
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 07:31:17 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uNVI1-0005K2-DC
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 07:31:15 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so3960916a12.2
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749209469; x=1749814269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjTsbK4wtIzn/jKCSOg8StG+XuUFcrrGPQe+iPfN0n0=;
 b=AGX0KihMsjnNRcRJCSDT0aJYYyH/qTV2cEuAf0QpmRLXTtwgmsILwE11wJCn3iCyA7
 3YFmtUPfJTrsUQZVzDCEMv4A7v23Z2MZrG1WQCOs7uy8vuA33Ibx0BuxKtfS8GkTRvtR
 5sIrnrDT4qbpRnBjo7qK31NuXEBCr9PPzigK3YKSPnBr/tou6WfbjARmreth4MeHP8VH
 +bVoItv5R0R66iPBYbuyed+fTPIedxM4qs5FNLXavHSAGklnDmxFs09wX9nDQo6kQ6pD
 okbXJnsC/XPVXR+6eAv86m4dboI59XeEGHUP7d9T6dBATFPT9D5nZ8v8eBLGHPy8qRyW
 V3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749209469; x=1749814269;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XjTsbK4wtIzn/jKCSOg8StG+XuUFcrrGPQe+iPfN0n0=;
 b=I96B7hK7t4BmdcM8ltQFVZTJyHowsaVhOXgZhp+b7iZ+FLZ5L4flneRDCyFv0enemb
 St6P8kbIxKFF3aFbBHCRfLwD89Oyg14VzPLrJ3tkJzMgJO7PlOG3l6y+Mz0c37ORHW88
 1yFtFKArmYnlxciKRVj6ru/3fCafDt34mFkdK+yQBS657LKn7aYQs7T3T2uewELhaXb6
 Ffur++G8u/e9M/cNVR/du6TKplfQ29fN5WY472qzB4Jcq79FZ+lxOvci5BMvkBn5RgNu
 xCdUq5tbf6+rAXXNXSOqPIx0JBjW8m7Xh3+b7/PRL4suixFYOiHV0ZmZiSvrkuACp8tt
 tUAA==
X-Gm-Message-State: AOJu0Yxw2sPlE+sOvLIhgtq5CPe6L+LERZYFoaxkLJm3VF7x8Y8qBayr
 lnfK4xk4d3ycV0rZclN1EZGsNNv8woJ8A2SdgBQe2lFgyxjMyGWeqB4x/DCmxli5OuE=
X-Gm-Gg: ASbGnctL0O4rXNADC1UqV/M/61oSIfA4bZM/wc2qhgkYvG32AdCMpr8WYpJbbjESpMq
 E944R3/zxfhLY0D0oUnh7JKvWNprS3e50uhFaBC9mRiKivBUiYoRhJMOoua9FcUFt7SoRbzAsSK
 CNIqV7TASq7PWXB8tcHyL+UNTPqzW0r4qgsJzoRmv1QhGs/DjEuPf0rZYnsWPKjJA87bkJPvsjN
 LToDQLm84UFKiucprUE1E/D+/3uDzzoPVIEM8psNSWuO1VnOqCHQqZp5D034PZFZcgsQQZaJmaE
 lXAdyG/25XNe/KmdqACDLd/1YMRUTKKtGDGG7dU27qspQgnx/+0CC6iCSB/07DE=
X-Google-Smtp-Source: AGHT+IHqnNl8ajV4tJMjspXbM1+QLBi5+QAtZ5KTwvlDXIBETxQ0F4j9SC6qUd4NybGvddoKgg7Ajg==
X-Received: by 2002:a17:907:968c:b0:ad5:8594:652e with SMTP id
 a640c23a62f3a-ade1aa4879fmr245116766b.35.1749209469187; 
 Fri, 06 Jun 2025 04:31:09 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ade1dc1c4c9sm102865266b.108.2025.06.06.04.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 04:31:08 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E505E5F7D2;
 Fri, 06 Jun 2025 12:31:07 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  qemu-stable@nongnu.org,  Dmitry Osipenko
 <dmitry.osipenko@collabora.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PULL 09/17] hw/display: re-arrange memory region tracking
In-Reply-To: <59bed3d3-f641-4b78-96bf-8fec25d74a35@rsg.ci.i.u-tokyo.ac.jp>
 (Akihiko Odaki's message of "Fri, 6 Jun 2025 19:31:44 +0900")
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-10-alex.bennee@linaro.org>
 <ee5115ab-b818-4746-8806-5056f3570011@rsg.ci.i.u-tokyo.ac.jp>
 <875xh95h5n.fsf@draig.linaro.org>
 <59bed3d3-f641-4b78-96bf-8fec25d74a35@rsg.ci.i.u-tokyo.ac.jp>
User-Agent: mu4e 1.12.11; emacs 30.1
Date: Fri, 06 Jun 2025 12:31:07 +0100
Message-ID: <87o6v13y4k.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> On 2025/06/06 18:54, Alex Benn=C3=A9e wrote:
>> Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:
>>=20
>>> On 2025/06/06 1:26, Alex Benn=C3=A9e wrote:
>>>> QOM objects can be embedded in other QOM objects and managed as part
>>>> of their lifetime but this isn't the case for
>>>> virtio_gpu_virgl_hostmem_region. However before we can split it out we
>>>> need some other way of associating the wider data structure with the
>>>> memory region.
>>>> Fortunately MemoryRegion has an opaque pointer. This is passed down
>>>> to
>>>> MemoryRegionOps for device type regions but is unused in the
>>>> memory_region_init_ram_ptr() case. Use the opaque to carry the
>>>> reference and allow the final MemoryRegion object to be reaped when
>>>> its reference count is cleared.
>>>> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
>>>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
>>>> Message-Id: <20250410122643.1747913-2-manos.pitsidianakis@linaro.org>
>>>> Cc: qemu-stable@nongnu.org
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Message-ID: <20250603110204.838117-10-alex.bennee@linaro.org>
>>>
>>> I have told you that you should address all comments before sending a
>>> series again a few times[1][2], but you haven't done that.
>> I've given reasons. Thanks for your review but you don't get to
>> veto.
>>=20
>>> I pointed out it has no effect (fixing or improving something) other
>>> than adding a memory allocation, but you didn't make a reply to prove
>>> otherwise.
>> I explained the commit cover what it is doing.
>
> It still doesn't explain the motivation.
>
<snip>

It fixes the anti-pattern of embedding a QOM object into a non-QOM
container. It enables in the following patches the lifetime of the MR to
be covered controlled purely by its references and not be so tangled up
with virglrenderers internals.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

