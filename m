Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19004CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:21:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNDo-0002gR-4A; Sat, 30 Aug 2025 11:10:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1urveX-0002gg-JG; Fri, 29 Aug 2025 05:44:13 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1urveV-0001rZ-LX; Fri, 29 Aug 2025 05:44:13 -0400
Received: from [IPV6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57] (unknown
 [IPv6:2a02:a03f:eaf9:5401:5fb3:a398:4351:5e57])
 by apollo.dupie.be (Postfix) with ESMTPSA id C208F1520F79;
 Fri, 29 Aug 2025 11:44:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1756460648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6/o54wxR9FwVRpvqZm1TmaryuW76VgfVQjShAIJxiyA=;
 b=c8POfiAT4OgwGM430SeZTomkk9U9Oh31Mp1Q8OElsuO2gUsaIU1yXYc+CUIVSmCiqf7XTY
 Yjj0eWt+AF4hpRQwEA775+r/XVDWduGFyFx3TWVrVCtgresBm1d1PfJ0YzUD1eXd2qnXpR
 6sQSWvr0fRP4oBobyYGzZJU7latMLhK+vRt/4a/CIVrrIwgeQyhR+L7ooUItkk6RSqKalT
 aaIkw3b/dctwqfVrR7Bb/58EOomvhC2XHyzd3KINIvRRXRNTaIC6tWGEoFQDec5lbYnfmf
 eA7eQb0ig0DGK3dtaV3x3gaZmdt1hDCr8khGaGUedl+Npax1T34NAJbx5vmfLQ==
Message-ID: <5f458e96-1f25-4d6e-a24e-430079210f56@dupond.be>
Date: Fri, 29 Aug 2025 11:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: add for_commit option to measure
From: Jean-Louis Dupond <jean-louis@dupond.be>
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20250416071654.978264-1-jean-louis@dupond.be>
 <20250416071654.978264-2-jean-louis@dupond.be>
 <a1aa1173-5362-44f6-8b64-6d44f1b5eb82@redhat.com>
 <bd78687d-2be5-4ad1-9493-2513af223f6d@dupond.be>
Content-Language: en-US, en-GB, nl-BE
In-Reply-To: <bd78687d-2be5-4ad1-9493-2513af223f6d@dupond.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 13/05/2025 16:10, Jean-Louis Dupond wrote:
>
> On 5/12/25 13:16, Hanna Czenczek wrote:
>> On 16.04.25 09:16, Jean-Louis Dupond wrote:
>>> To specify we use measure call for commit size calculations, we add a
>>> new 'for_commit' option to the measure call.
>>> This will be used in following commit to do a different measurement.
>>
>> Why not allow specifying the node name (or filename) of the commit 
>> target instead of this just being a boolean?
> Honestly didn't even thought about that option :)
>>
>> (That was my main problem with the original series, that it wasn’t 
>> possible to specify the commit target (in an obvious way at least). 
>> I’m not a fan of deferring to JSON parameters for this, although I’m 
>> aware that to specify the node name of the commit target you would 
>> have to use JSON again, unless qemu-img can do some translation on 
>> behalf of the user: Looking at `commit -b`, that takes a filename; it 
>> could make sense to have the internal QAPI parameter use a node name, 
>> and qemu-img translating the filename parameter into a node name.  
>> Actually, `measure` could just accept the same `-b` option as 
>> `commit`, which it would then translate into the QAPI 
>> `for-commit=<node-name>` option.)
> And you will need to use JSON parameters if you want to specify 
> something special, like for example to note that the commit target has 
> discard-no-unref enabled.
> I think not many people will call the command with the for_commit 
> option, but it will be (always) called from code where the JSON 
> parameters give much more flexibility to add some additional options 
> (like discard-no-unref).
>
> We could of course support both (JSON + for-commit=<node-name>).
> But then we will also need to validate somehow that the for-commit 
> node-name is equal to the target specified in the JSON somehow.
> Or have something like for-commit=true/false + json or 
> for-commit-node=<node-name> if you don't use a JSON?
>
> Do you think it's worth the effort ? :)
Kind ping, no response on it since then.

Thanks
Jean-Louis
>>
>> Hanna
>>
>>
> Thanks for the review!
> Jean-Louis
>>
>>> Signed-off-by: Jean-Louis Dupond <jean-louis@dupond.be>
>>> ---
>>>   block/qcow2.c                    | 16 +++++++++++++
>>>   include/block/block_int-common.h |  4 ++++
>>>   qapi/block-core.json             | 28 ++++++++++++++++++++++
>>>   qemu-img.c                       | 40 
>>> ++++++++++++++++++++++++++++----
>>>   4 files changed, 83 insertions(+), 5 deletions(-)
>>


