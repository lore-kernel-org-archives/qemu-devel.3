Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67ADCC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 21:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzhHj-00028m-18; Thu, 27 Aug 2026 17:05:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzhHh-00027h-4R
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 17:05:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wzhHa-0001Jq-RI
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 17:05:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787864707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UbS11Ua1ZpYOq5wv+TY3eDaf+GMY5I5lpbVIpxhf5c4=;
 b=RgSgeC9ZXbvmGA8DEBXX4Fr1rezT6GkKVyrlIOyMfCS0tkN3EubTDcDwJVK2kLXymbdml8
 7AEwSmJo4p9w+0csRu1GpbqPkt8byxhsZ4Qo+OZOs30SE9sGY05siTmOtMBxhKTWo8Rkmr
 iWLvkRRNHosBJP2iQTeJR6vGjdridto=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-GkHQumBKNomLsrywyNHyDw-1; Thu, 27 Aug 2026 17:05:06 -0400
X-MC-Unique: GkHQumBKNomLsrywyNHyDw-1
X-Mimecast-MFC-AGG-ID: GkHQumBKNomLsrywyNHyDw_1787864705
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-472c330e555so30867f8f.1
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 14:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787864705; x=1788469505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UbS11Ua1ZpYOq5wv+TY3eDaf+GMY5I5lpbVIpxhf5c4=;
 b=N2bFPItv+yjAEU592hRf/K+7C1VP2yCGqjn2qbhvkb+H4m5x2Uur9RK/Ox765WqrUP
 k8jOqdb4sThdH9NIfYQQmehTVcvm33NCGEDheBknp46yIRXfrloJCqSPi9N9SOLmZZ87
 YE+ln5Pbr+0Xs/PBOPCunpf/eyuOUcHwi+wKDnbKub2yBHt0PU5eUrfbOt+Oj2xCrx/0
 TEdju5VBYjMSimvI2nOeKBa3V32G9Q1D9CR7HI0So7wq65yjBFWkdGLMMoUFSJdNFzvu
 b4vPzFwJnQjzayh8lPk3SGUhwyqKC2NAExGo1xrEfBdmSkXnrhxMwOgqzj9BIP7BymBO
 SLiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787864705; x=1788469505;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UbS11Ua1ZpYOq5wv+TY3eDaf+GMY5I5lpbVIpxhf5c4=;
 b=QX8MaVM44OH2meiHt5CVa+qtAf2VmojIafUP3rnQ8B1s0FrtjPxc4Nrgj1aTFm7mdt
 R7YQhp1Fg3MBJeCf6E2DbCadyiO/NbzX4+h/UVwy69bj7w5ZQ6VDl90xq3ZsK49dc6XU
 xVzy4jvru5UO4Hf06qPW/6w6SK9lzdWJfL4pRyJmE+vtqhVreXeS8SIpnZQud8kZmdl1
 4F3aABDZuqzApePeIIqmSSx1ryeSVpGKtUV3KR4ChMdlGgDpg5Qd1bl4vXphKsp7UXhx
 KB0k9U26gW8rfVpqeZd4sfCb473V4O8D86b9ZJ2BR/hfLY2Ze5ORFAbJvGBO3up2ebXo
 wPMQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoxT7ZdK/V1CEYFsUMcezITPmxAwG2hyrcr6XzZVobRIyda+n+v0DtFpdjJuiBTOtKHIW/Ntl6rluq6@nongnu.org
X-Gm-Message-State: AFuF++mu0kVQZF0xcro9wvot3eOLZDw8sqXl6eP6HoVR20wAimg5IX28
 EIjf+bq472LbFTm6lid7R3wFlAJLbnIbLu0qw4yYjHwN7CCLbCotXrh+u1JyYXjSJ44GrN86mzT
 kZK5gr8g2vGecRTxUKQjyp7IyJ5CgwbVjQ8lhJzIRy5KtMnn0SEffUDtl
X-Gm-Gg: AR+sD11LGdu9xJNQq92uXhaR6xUHweSWNjBWJFXwmSdqTXicM9u5/pLwn9udJCYky2X
 cI+2ELTCAX00F/4taRJJ/rSZPId9SxpHTu1Zvs51mpTglmRxUSS2SBWhdxUk/uh40eLxL1YltIj
 8R5SX/CKErHNJGbcD7ytmyjNOyoj0lFy3yKUhySFXcuHYRL/djWAJO57z6OJxVge8NSzwJWLh2d
 DaxmX79GqQCAYAVJBhN3ewDH0W3NDmcy+UEEJYfB3oZS8gAsI5IVwUb94YrkQuuP2vq3P3nXomf
 y4ysE2RZ7p7+yv357SHOXzpxt99usvnx5ZQz1a189I2dKN4FdgdV2j2lwEQ+YM9pxN9fbkbUwg=
 =
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482f79c1923mr2246942f8f.10.1787864704790; 
 Thu, 27 Aug 2026 14:05:04 -0700 (PDT)
X-Received: by 2002:a05:6000:4910:b0:482:a8b1:aa6d with SMTP id
 ffacd0b85a97d-482f79c1923mr2246857f8f.10.1787864704036; 
 Thu, 27 Aug 2026 14:05:04 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dbe1dsm12181744f8f.22.2026.08.27.14.05.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 14:05:03 -0700 (PDT)
Message-ID: <faf8b6b3-b4a1-46d8-b9bb-e36c096e14e8@redhat.com>
Date: Thu, 27 Aug 2026 23:05:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/about: Deprecate the 'next-cube' m68k machine
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Natalia Portillo <claunia@claunia.com>
References: <20231007072313.22108-1-huth@tuxfamily.org>
 <1826b106-2b9a-41e2-81a4-8a3439f9c511@ilande.co.uk>
 <bf3036ba-0259-4757-a249-68e2a15af1ea@redhat.com>
 <74883723-8f58-404c-9bab-ddb9a4aef4a8@oss.qualcomm.com>
 <CAFEAcA_ALPTQLQwA_XzqOr=Zuc4_K9=LPNXN9jN_i0fyouqwxQ@mail.gmail.com>
 <apB3oX536mOoPoXt@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <apB3oX536mOoPoXt@redhat.com>
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

On 27/08/2026 19.45, Daniel P. Berrangé wrote:
> On Thu, Aug 27, 2026 at 06:32:43PM +0100, Peter Maydell wrote:
>> On Thu, 27 Aug 2026 at 17:09, Philippe Mathieu-Daudé
>> <philmd@oss.qualcomm.com> wrote:
>>>
>>> Hi Thomas,
>>>
>>> On 27/8/26 14:54, Thomas Huth wrote:
>>>> On 09/10/2023 21.39, Mark Cave-Ayland wrote:
>>>>> On 07/10/2023 08:23, Thomas Huth wrote:
>>>>>
>>>>> (added Natalia who was the GSoC mentor for the NeXT cube work)
>>>>>
>>>>>> The machine is incomplete, and unfortunately the hoped-for improvements
>>>>>> never happened. So it's maybe best if we mark this machine as deprecated
>>>>>> and finally remove it again in case it gets into the way of a code
>>>>>> refactoring or other reasons.
...
> I don't mind about the quality, as we never claim this stuff
> is providing a security boundary, but I do wonder whether the
> bar for merging a machine should have been higher than
> "shows firmware prompt" ?

I think merging machines that are only partially working is fine as long as 
there is follow-up work that takes the state of the machine further in the 
direction of completion.

The 'next-cube' machine looked promising first, and merging the code was 
good to prevent the state from further bit-rotting, but unfortunately it 
completely lost traction in the course of time (except for some improvements 
in the related SCSI controller, big thanks to Mark for that work!). Anyway, 
in such cases when there is hardly any progress anymore, we should admit 
that the experiment failed and finally remove such machines again.

> Are there other machines we have merged with that level of
> very limited functionality ?

According to 
https://www.mail-archive.com/qemu-devel@nongnu.org/msg605124.html the 
xlnx-zynqmp-pmu machine is in a similar unfinished state since years.

Maybe also check https://wiki.qemu.org/Testing/Machines to see whether there 
are other machines that don't have a test yet ... those are good candidates, 
too.

> Is it reasonable to say "boot a guest OS" is a criteria for
> merging machines in future ?
I'd say no, work in progress code is fine, as long as there is progress. But 
if the progress is gone and the machine never reaches the "boot a guest OS" 
state, we should also be fine with deprecating and removing it again.

  Thomas


