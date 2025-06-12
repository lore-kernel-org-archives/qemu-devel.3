Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D42C61CE8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 05:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPaFD-0000Nq-0L; Thu, 12 Jun 2025 01:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPaF2-0000K3-06
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 01:12:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uPaEy-0007En-TD
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 01:12:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749705159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=c+r1Aw78LMaAoIi8npdIYWeojNaOochN/eiG/UlZweQ=;
 b=Btf/XT0OyQVpDdLDY686Y4FsIjcEfiolEcltCLx+9gOSjj7mxizKSH6UpbqmaczqTTKM77
 cD7cz+QBKBqhyhHqhJWg5ks4Jkk8tgOlaNknynyujMv7SKGCEBk0pwYlw6XZhFM4LDOewK
 ojDkMOc14FSGkxanCuUl6RhfwEu9hgw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-tedBEXMaNNyY9xChvTisMg-1; Thu, 12 Jun 2025 01:12:37 -0400
X-MC-Unique: tedBEXMaNNyY9xChvTisMg-1
X-Mimecast-MFC-AGG-ID: tedBEXMaNNyY9xChvTisMg_1749705156
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so3346065e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Jun 2025 22:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749705156; x=1750309956;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+r1Aw78LMaAoIi8npdIYWeojNaOochN/eiG/UlZweQ=;
 b=P9zFpiMNn5G71D8RTRPbsEol6X+pLciMe5FA2NHmp4/TIBCc8QLsfTVNzj6eV+VZzi
 RD7G+QVOrS3cHhILlFYI2yxdjDJtVD+xW/grA3nmxgHtA3h19vV6XdgzdQYG7ppBzMtd
 mkLXLouaK+ovLjr5usU2vhMDhwzTB1ofbC9XLoZ4cG4qiUCssf7Th0eeiORHHaI9BU4K
 ovfsLLZfvONEB0JxnP2Yoh6uyappp/bECpkJc1zOWrm+yR4UpGkIyGjeaGNhTBQpnmof
 mRI3N+Ex55KXGfRjEL6rxrfBXq6gyz8XeIKnXEjdDz2wroVbz/d2dFqbY2NdS7q+4/2N
 vGbA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXA3YGfX3Sl0aK1PVsvZ0ocPfYcornbnW+8hKxoWR+lIab2E1skIyy2FKZ2s1+fAx5epL9cMF5TF0rA@nongnu.org
X-Gm-Message-State: AOJu0YyZrwRX2GzfHvo+JXya0wrLCTHEF7iKWK8IffGP/aiyMoc0BBEs
 dRaSgdrILgsHk2zZ36EK4xZyv+Nl3+D6ohuPpXGjJ8CLQC0eZe1ZetOJCPNqKn92RY7eTkAo/ML
 OXpwqb+72eJ7vhH5krendNN9aJFnkX8VzwGRejVnzCJQsS/o+JBPk/lLt
X-Gm-Gg: ASbGncv4TdYmKalomNWk6OPJ+sxXo0suuIkm2xHVXnnvj/WKIvdlJmke19IMavVespq
 JJmzWrbTISc/n732LPzC8hOmO+HPAOZQq7+vucycDhfeUh7B+hWphkV1pNekFNW9OKwUiYJjsd1
 XlpiBM9T4JET9jUy0VzvmtxeXF+yB0RFAWj7gnCceb2GXlMGo+k8YyKBiQNq04tj1EAZdMUp0ju
 WUKodv34qxydak1zjPrY4GfYvXtdb75jn/4SGt8UvWcQTxvIXiPvYDDMAmlQLzsRSKCtRBw2P2b
 zN4S0hvSYgwYvxpuIG5sjskU
X-Received: by 2002:a05:6000:40d9:b0:3a4:f661:c3e0 with SMTP id
 ffacd0b85a97d-3a5614c3021mr955386f8f.45.1749705155802; 
 Wed, 11 Jun 2025 22:12:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFidzyN9XidR4eT7Ha0q1lfbCkbXePqbuh4cPVTv+HiGFAoO0zQlhvMRfFsFSoRopdA+z+P5A==
X-Received: by 2002:a05:6000:40d9:b0:3a4:f661:c3e0 with SMTP id
 ffacd0b85a97d-3a5614c3021mr955370f8f.45.1749705155368; 
 Wed, 11 Jun 2025 22:12:35 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.64.79])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a561b65c2fsm836966f8f.98.2025.06.11.22.12.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Jun 2025 22:12:34 -0700 (PDT)
Message-ID: <c29386d1-1a4b-4f3b-a669-4206c366ad9e@redhat.com>
Date: Thu, 12 Jun 2025 07:12:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] configure: Add dtc option
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250610204131.2862-1-shentey@gmail.com>
 <20250610204131.2862-5-shentey@gmail.com>
 <cdfc561e-23a9-607a-d9a8-70e07e73e0fd@eik.bme.hu>
 <aElCJnmjrB-X9M-n@redhat.com>
 <6eb6aa79-33f8-57ea-5714-af264557f8c8@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <6eb6aa79-33f8-57ea-5714-af264557f8c8@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/11/25 13:45, BALATON Zoltan wrote:
> On Wed, 11 Jun 2025, Daniel P. Berrangé wrote:
>> On Wed, Jun 11, 2025 at 02:37:08AM +0200, BALATON Zoltan wrote:
>>> On Tue, 10 Jun 2025, Bernhard Beschow wrote:
>>>> The next patch will make dtc mandatory for boards with a bundled 
>>>> DTB, causing
>>>> these boards to be omitted when dtc is missing. Allow packagers to 
>>>> force the
>>>> build of those boards by providing an option.
>>>
>>> I don't like this. This might result in some machines missing from some
>>> distros if they don't notice this and forget to update their packages 
>>> and
>>> these are machines I care about.
>>
>> "Someone might not notice & screw up" is pretty much an argument for
>> not doing anything at all. We publish release notes to alert distros
> 
> More like "if it ain't broke don't fix it".
> 
>> to these kind of changes which is a reasonable effort on our part.
>> Distros need to play their part by reading them and adapting to the
>> changes. They can also compare the available options with new and
>> old QEMU to identify any new build features they need to handle when
>> updating.
>>
>>>                                  Also what guarantees that we don't 
>>> get bugs
>>> by compiling the device tree with different dtc versions which might
>>> generate different binaries? The binaries we have now are known to 
>>> work and
>>> don't take much space so keeping them for convenience might be 
>>> simpler. If
>>> it worked so far why change it now?
>>
>> Ultimately the DTC project has responsibility to not cause regressions
>> in new releases they issue, as is the case for any 3rd party dep that
>> we rely on.
>>
>> We have CI jobs that can run on different distros. If we have coverage
>> of the boards in functional test suite that provides a way to validate 
>> the
>> operation with differing DTC versions as a sanity check.
>>
>> Distributing pre-built binaries in source release tarballs is a long
>> standing issue with QEMU's releases. If we can eliminate the pre-bbuilt
>> DTB and only ship the source that is a good thing IMHO.
>>
>>> If this was using dtc from the submodule when not using system libfdt 
>>> then
>>> at least it would not result in dropped machines and we had a known 
>>> working
>>> dtc to compile with. Why isn't that used when we already have it for 
>>> libfdt?
>>
>> Are there any platforms that we target which still lack dtc ? The
>> submodule was there to plug gaps in distro support long ago, but
>> if every distro has dtc available the submodule is redundant.
> 
> OK, can we then make libfdt and dtc mandatory and not build at all 
> instead of disabling boards without it?

Disabling libfdt was done because of the x86 microvm board, which was 
adding a libfdt dependency to all of qemu-system-x86_64.

However, several targets still have a hard dependency on libfdt, plus 
libfdt is supported as a subproject and will be built together with the 
emulators.  So the impact of the change was minimal, and limited only to 
people using --disable-libfdt or --disable-download on the configure 
command line.  This is not true of Bernard's proposal to use dtc.

For now, one possibility is just to make dtc mandatory whenever one of 
this boards is used; the best would be to be able to use the dtc that 
comes from the libfdt subproject.  This however requires patching dtc's 
meson.build so that it calls meson.override_find_program (and it could 
also use meson.override_dependency while you're at it).

I'll send a patch to the upstream dtc project and you can add it to QEMU 
via diff_files (see commit 64644bc4eab2f for an example).

Thanks,

Paolo


