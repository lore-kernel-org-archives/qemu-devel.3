Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0B80D6D226
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 14:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWEon-0006SZ-Fx; Thu, 18 Dec 2025 09:17:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWEof-0006Qc-Vf
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:17:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vWEod-0003tQ-CE
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 09:17:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766067434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BnPHnpyj7SEQm2fuDo5kQcz2GUu75xVHwX6+XVlUngE=;
 b=W0+EaVm68hA4K/JsuZUkNEIhS0q5q9D2967Z+b3/ghr1nvpAPlAJGdTpN3PlTcFbxfD1BU
 95vbd1pbAocID1o+Hn3uJ1EscmA0xyvIO+qnFNsfEYQVobIXyGQcXh40rQDp8fOMDJovxt
 lApgibYfl6uxgOH7OugnxWgAtUn0xGo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-VNm4kbFMOlmIQOU8hPiQUA-1; Thu, 18 Dec 2025 09:17:12 -0500
X-MC-Unique: VNm4kbFMOlmIQOU8hPiQUA-1
X-Mimecast-MFC-AGG-ID: VNm4kbFMOlmIQOU8hPiQUA_1766067431
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-430fb8d41acso343434f8f.1
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 06:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766067431; x=1766672231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BnPHnpyj7SEQm2fuDo5kQcz2GUu75xVHwX6+XVlUngE=;
 b=CdNgcwgxfyKdxKPgJCkoyKuLYqQzrvSq2FP/0bt1M2aw0CNhZ3f2+XSMYfTANjDTUQ
 6yLK9m58qwbdPf4/MnoNV16XXhoRpi0F7rJkeqWJvh4euOnS1vONk7OV3upVolaf/CjC
 0skkXyngGR82TnlDfRvxSD5afHMEFQHLebL5O4GdIylDfMXrlgYRk1b3F2HYxnHvM8Hl
 7EduscqZDvW5ryvy9lRAmmeL13sGpznmtuFQkBNBsOapHLNy9UstsZyeggP3CYrlgfRx
 LQh1Mdy1E4r9tIoDFrLgpbpcHjQjYRUBDXp5JLz8/PKZRiezZBqOoqafSsBifZ2UZr89
 ZK+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766067431; x=1766672231;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BnPHnpyj7SEQm2fuDo5kQcz2GUu75xVHwX6+XVlUngE=;
 b=g+niFAv/m8tguRHrcY5W2bSSdH2Fm0dyXgF+XjMq3vjA0TplgqTraI2K463iNJQsxD
 L0n2VdoXP+GcombCssDO8cCkTeH7lZAaq59wA2neigrDiJDs6d0ez9+I+HhObeA6jBlv
 I6WlOkgc5MhsziqxmwXCU0Jix4tGvx5uZyGnCNBCJy8nIXDb4scEVtD2TdvQsW0W4egj
 MANIO0rGGZFU4erdks+8Hi6BfeEx3HGXG5TtwpOm8If29fScoXRixm1ZTOHBIg40TlhP
 GYRXChrLDZrnK6WT7yr/aClIHvYbPQbrAItsvzASCymuSv4xp3t9Kwm1GkyK6jdZ2Q/7
 VSTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcCh9JS+2sv1r54UWxh1kVBAtCugw0gua/djFsLIYlwecr1kWYbkI61Z4PyDSn5S4BWehPFZqHA5hi@nongnu.org
X-Gm-Message-State: AOJu0YxWL1Lv7enOlmVPPhCPG4EVUUtmp8OJQuZ2fkToDnxtmm+xnlV7
 +2RowS+UGXuWWdOc8imwEuDnnOkUIGGGNradbDkpI344oAFNfUwx14Oo76K+H6C7MIhwCMGx4th
 +b7/JeBhl0sR+g4+Dd8l46G76lBlf9X3Pm4DF7Mwaif7437SrOujKx9Df
X-Gm-Gg: AY/fxX7iJRKyXyCDHKtTEZriP4svrOYl3mgHh3OD4isroHS63ZoaXOLnhvC6qm0Pq2b
 69GclOMTl0KlqpVvSF7xDz1BbWay6CStWHkMPL++VZjgtRJxB1qcmaHaNzVfokWvOuciqnhpZ2Y
 iu+zHjfmd0hqu/juJfsE0jVlBPBSWEPI/CO64ssJrTFzv0aVnAVWYn9r6GrnaZ1ftD3XMhFQenb
 sDzafw1UMLqI5QBfdl4cSmU5A9GiwBVMoUOemI7KeLwe//2sSrGMN45KrpQhK4UnqP7SSqAd4IB
 DN9EtFeFn1dcGyfgf6BaIYJdoIXZ8J77CbIrG1x1iSIRG5L34MyVdhDdCTazDwM/8PfquT7zwA9
 xx12HCqo=
X-Received: by 2002:a05:6000:2909:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-42fb46ec6cdmr24303134f8f.42.1766067431420; 
 Thu, 18 Dec 2025 06:17:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSiKBINMuI+bHl8op8FrI/GbAfwIj989ZzEJM1tMnOkvQ8N7/6uPOVkFU9jyw3ZIhlvndtSQ==
X-Received: by 2002:a05:6000:2909:b0:425:769e:515a with SMTP id
 ffacd0b85a97d-42fb46ec6cdmr24303103f8f.42.1766067430990; 
 Thu, 18 Dec 2025 06:17:10 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43244934cd4sm5186326f8f.7.2025.12.18.06.17.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 06:17:10 -0800 (PST)
Message-ID: <7dc9c551-19e9-4662-bf1a-6f33fa4be7fc@redhat.com>
Date: Thu, 18 Dec 2025 15:17:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Report on MAINTAINERS coverage
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
References: <87h5toc61n.fsf@pond.sub.org> <aUP5znRDyuBlpGvW@redhat.com>
 <871pkrdi6w.fsf@pond.sub.org> <aUQGWes2pCSWTDfe@redhat.com>
 <288b1dae-68c5-4b48-ab08-62a7b08245ea@redhat.com>
 <aUQLyChpa7qc_PfH@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aUQLyChpa7qc_PfH@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 18/12/2025 15.12, Daniel P. Berrangé wrote:
> On Thu, Dec 18, 2025 at 03:06:00PM +0100, Thomas Huth wrote:
>> On 18/12/2025 14.49, Daniel P. Berrangé wrote:
>>> On Thu, Dec 18, 2025 at 02:37:43PM +0100, Markus Armbruster wrote:
>>>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>>>
>>>>> On Thu, Dec 18, 2025 at 01:45:24PM +0100, Markus Armbruster wrote:
>>>>>> Which unmaintained files are we still changing?  Unmaintained files
>>>>>> sorted by number of commits in the past year (since v9.2.0):
>>>>>>
>>>>>>       $ for i in `cat unmaintained-files`; do echo -n "$i "; git-rev-list v9.2.0.. $i | wc -l; done | awk '{ printf "%7d %s\n", $2, $1 }' | sort -rn
>>>>>>
>>>>>>       107 tests/functional/meson.build
>>>>>
>>>>> Opps, that's a mistake. It should of course be under the
>>>>> general maint heading "Functional testing framework"
>>>>
>>>> Thanks!  I can patch that.
>>>>
>>>> What about the other uncovered files in tests/functional/?
>>>
>>>> tests/functional/aarch64/meson.build
>>>
>>> [snip many more]
>>>
>>> I'd wildcard   tests/functional/*/meson.build under the
>>> general maint.
>>
>> Either that, or make sure the the architecture maintainers own the whole
>> tests/functional/<arch> folders.
> 
> Yeah, its a 50/50 decision from my POV. Most of the content is
> just a mechanical listing of test files, but there's some level
> of thought in the appropriate test timeouts which might push
> towards the arch maintainers owning it.

Thinking about it twice, the file is often only changed when adding new 
tests, so that's not related to the generic functional framework, thus the 
meson files in the architecture sub-folders should be owned by the 
architecture maintainers.

  Thomas


