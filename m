Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD316C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9KUD-0001WI-LE; Wed, 23 Sep 2026 06:46:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KU9-0001Vs-EY
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:45:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1x9KU7-0000Jy-C3
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 06:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790160353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rHEIPt3kYj+mW2XEboMpeAVFfUlem94Da4tnNxpxL9M=;
 b=ZzaOj9C9FLM9voqdbmYTG+8ZjDTga8NG+2qL3HRRIv/kbCi0MaF6ial9vdaO1kiMnURdxY
 LE5aVnqIOPHW9fDhEZeJTuLr9i/pO5EuQo6oQ06m8BQL2GWcf3Bjoj85dNmWzZjLqBpX6l
 lJxCsDTid7uO+GX5By6rtWKLRnnpgmY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-slYZ5_8gOwaLUZ1HWdzjvw-1; Wed, 23 Sep 2026 06:45:51 -0400
X-MC-Unique: slYZ5_8gOwaLUZ1HWdzjvw-1
X-Mimecast-MFC-AGG-ID: slYZ5_8gOwaLUZ1HWdzjvw_1790160350
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49e6862e924so5174085e9.0
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 03:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790160350; x=1790765150; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rHEIPt3kYj+mW2XEboMpeAVFfUlem94Da4tnNxpxL9M=;
 b=QUN07yW05rDkoqa5GciF29V58zBaTbXSt7bcmP2mBpnZVPTCwnLmUiLkOk+zhToTQ2
 OE+f52yJScFPJd5qRFSFyTLt5U7rZVSnUx+HKTJyOOz0rgNO9B4V+XF41SZ3Oqv4jtDA
 obM+fN3cHwQONiB666pSrKh4j2YRUzxJJDJNmh2dKaVPj78c/mrD1B8R6/cWPTqvlt+O
 Oiu6KjGMYgJWKAtlbVIebWhHdVeT802wo7+wxFt1b8SKlMZU0TKU6+wmhqakdMmEGt6W
 D8Epn6fIOELhr/DcvUfxyXNIiQ0t3jhtABLllU+XaClZtNbKhO7t5FQTXGsLO00VORmU
 9NaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790160350; x=1790765150;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rHEIPt3kYj+mW2XEboMpeAVFfUlem94Da4tnNxpxL9M=;
 b=ojdj5Sjze2R+GqYBnxyF+r5XKew/gk8Iatj7C16cUg0uzkwkDeTjJXRiyL3FAsfj49
 /1ReBmG+z/JyckksjR3tcXbKUunrzVQNYMj9k98n3yWdfBB3D1fXJ35DvQ9r3UnNjklD
 TLRnso6mNDRciUkpPXCHj+tfVFwjBIroLfvE2Dj+WXiNyskG/m8OE7YykIQezAhNbdQo
 HFstmsQWWN0OL4cPF6IIdiwOzX23MKQsHr1NxxY0Qhl0MLX1D297T1ePZsgG5j9kYi+3
 qoP9GZhc4DGIrsbsJMANq6dOfElvW3qgtDAE+tU1eDawAy6MutNkpiGHqoi5fRJprMKw
 XncQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByyPzprPfd6aA3SBaGe3XSlXIrxR/aMW7IFahMJXnVy2AVA+BAkN1QSEDxTIVjBfUCqyfMfIcl7Kmhw@nongnu.org
X-Gm-Message-State: AFuF++l43IStzTnKV905NFW9Dtck0Ugiqf15UN+pMFgSSZnJlFcQRP1a
 yNRE5zCFWn87281OKz34qaer7EukAC0FhQ12JGMkI8S9vy38L/DkjVKKCpxnfFJb5iUIzlLOqv8
 6F99BZycyEC8eszeDoMt6E0GegftmkX5tRbuRo8vaCSEqpVkRDAgLdha8
X-Gm-Gg: AYBFou3J2XdgLpRiWEJclWB1gqFWtoEF5MNMF23vTwb9V9xGhVeFC19XXYfCt25qFxz
 oRgBcmjlXbN4sG83UL0EuqqYAUyyUdISVE1RGCuwRuCfJZtSkBr1yr+0QCof0mNz09SF2bSknTm
 Rh96JiB5uGnJXggMfVr2WMvdNpUDGyWMd+l2ifAwuX0ElwE6/OGF1WuqvU/V1HxBFZvhBRN9+6T
 n4gQjuAlq9atyR6HtCM0qjsvU1mJm/YBcqZpScLHEe26uWQUnr1hmoDEwhhTsPcQPvebRoItKVH
 m9BiQk64J+Sls4laTSb5P2Y4tYqOG6I091ctkmNMyxyrcmKuWB01h6LyntLWcVnvsHKu2Jo4kj/
 8K/7eETHJeUEYk3cHVPs7Y0zI08xDQnzUw8CpUJhrBkDuIpc6CeX9Y12Cm7rdvbyHZZa8dFVxgh
 56U4+Vc3idJaHcSP750jtQSc2PmClgyQ==
X-Received: by 2002:a05:600c:4ec6:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-49fdf12f351mr28006135e9.20.1790160350468; 
 Wed, 23 Sep 2026 03:45:50 -0700 (PDT)
X-Received: by 2002:a05:600c:4ec6:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-49fdf12f351mr28005835e9.20.1790160350020; 
 Wed, 23 Sep 2026 03:45:50 -0700 (PDT)
Received: from ?IPV6:2003:cf:d749:526e:3864:2ce3:24f2:e6d4?
 (p200300cfd749526e38642ce324f2e6d4.dip0.t-ipconnect.de.
 [2003:cf:d749:526e:3864:2ce3:24f2:e6d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fde18093csm78095585e9.3.2026.09.23.03.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 03:45:49 -0700 (PDT)
Message-ID: <d4f10160-a355-4232-9f72-eda0c6a0148d@redhat.com>
Date: Wed, 23 Sep 2026 12:45:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] block/accounting: Emit BLOCK_IO_DELAY event
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-7-hreitz@redhat.com> <20260903142359.GD825275@fedora>
 <28da45c4-51ce-452c-b7d7-a18b68d2dd1e@redhat.com>
 <ccada8d9-b94b-469c-9602-1d1085fdba47@redhat.com>
 <20260921204850.GE115897@fedora>
Content-Language: en-US
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20260921204850.GE115897@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 21.09.26 22:48, Stefan Hajnoczi wrote:
> On Wed, Sep 16, 2026 at 02:04:58PM +0200, Hanna Czenczek wrote:
>> On 16.09.26 10:14, Hanna Czenczek wrote:
>>> On 03.09.26 16:23, Stefan Hajnoczi wrote:
>>>> On Mon, Aug 31, 2026 at 03:52:02PM +0200, Hanna Czenczek wrote:
>>>>> When a request finishes with a higher latency than a predefined
>>>>> threshold, emit the BLOCK_IO_DELAY event.
>>>>>
>>>>> Note there would be an alternative, more precise solution: We
>>>>> could keep
>>>>> all active cookies per BlockBackend in a list and repeatedly iterate
>>>>> over it in a background coroutine (woken on a timer so it would wake
>>>>> always exactly when the next request would time out, so it generally
>>>>> stays asleep until there is actually a timeout). This way, we
>>>>> could emit
>>>>> the event exactly when a request crosses the delay threshold, while it
>>>>> is still running; and we could hypothetically even take actions like
>>>>> pausing the VM until the request is done so the guest operating system
>>>>> is shielded from extreme latency spikes.
>>>>>
>>>>> In practice, this is very complicated because latency cookies are
>>>>> created and finalized all over the place, so it is very hard to
>>>>> guarantee that every `block_acct_start()` is matched by the right
>>>>> finalization to ensure that cookies are properly removed from the list
>>>>> when they are done. Even if we fix all non-matching places now,
>>>>> there is
>>>>> hardly a guarantee this will be kept in order in the future.
>>>> I think this patch series already couples the accounting so closely with
>>>> BlockBackend (i.e. adding the offset field into the cookie struct and
>>>> adding a BB pointer into the stats struct) that we might as well fully
>>>> integrate the two. Then callers don't need to manually manage cookies
>>>> because BlockBackend does that internally and the concerns about
>>>> lifetimes go away.
>>> I don’t follow how integrating them into BlockBackend automatically
>>> solves the problem.
>>>
>>> Are you suggesting that blk_* I/O functions should do the accounting
>>> instead of the device emulation code?
> Yes.

OK, I see.

>> The thing is, AFAIU, doing that would cause changes in behavior, because the
>> hardware device requests don’t always line up with the BB requests.
> Did you find a fundamental incompatibility that rules out letting the
> block layer handles stats for blk_aio_*()?

I mean, a simple thing is that reset requests are currently just not 
accounted, but they would be accounted then. Or repeated requests after 
VM stop/cont.

There is also the fact that rerror/werror set to IGNORE means errors are 
currently accounted as 'done', not 'failed'. That makes… a little sense 
in the device models, but not really much sense in BB, I feel like.

So I am not sure what you mean by “fundamental incompatibility”. I’m 
sure if we make it sufficiently ugly, we could reproduce all current 
peculiarities. We could use the chance to make it cleaner, but that 
would change the interface, and “cleaner” is always in the eye of the 
beholder. (Besides the fact that I feel like you are trying to have me 
open a can of worms, I feel like. :) )

>> What I could do would be to abandon the cookie-based approach altogether, of
>> course; instead creating a completely different tracking object in those BB
>> functions and put those into a list. And then we could decide at a later
>> point if we want to integrate cookies with that. The only downside I see is
>> that this would mean the latency reporting would not line up with the
>> requests reported in the stats, or the histogram.
> The tracking object could be a timer! :)

The problem is not timer or sleep, the problem is the lifecycle.

Hanna


