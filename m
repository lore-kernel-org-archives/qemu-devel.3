Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B07C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2TLe-0002Kw-3h; Fri, 04 Sep 2026 08:48:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2TL9-0001rX-08
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x2TL7-0007EX-3A
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788526096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tq5KMhFBnIVo+NJEijoDMOG7Qosb7UKOdH/sdS6kPRk=;
 b=PSyrSHjo8uWFZU+OcGXy69YOb2LPoMU5PArY/Hi3whsolw0JTQ99wSpOi1S7F53eVFlKsC
 PJLo7NXAglbe3w08Zi3cR4imF+VoeuVc+aGcoC4j3bQVDt8CrVb+l+oi/LrHOyHlG70tGp
 p/s+T7BIlkCSo13Y78WbGDimig1lQRA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-aEnUB-nuP4ydBveevyj2Fg-1; Fri,
 04 Sep 2026 08:48:11 -0400
X-MC-Unique: aEnUB-nuP4ydBveevyj2Fg-1
X-Mimecast-MFC-AGG-ID: aEnUB-nuP4ydBveevyj2Fg_1788526087
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F037195F16A; Fri,  4 Sep 2026 12:48:05 +0000 (UTC)
Received: from [100.90.56.12] (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A98C2423; Fri,  4 Sep 2026 12:47:49 +0000 (UTC)
Message-ID: <b426be77-d233-4f45-9c14-889e95141b6d@redhat.com>
Date: Fri, 4 Sep 2026 14:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, qemu-devel@nongnu.org,
 Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Sunil V L <sunilvl@ventanamicro.com>,
 qemu-riscv@nongnu.org, Alexander Bulekov <alxndr@bu.edu>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Farman <farman@linux.ibm.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, David Hildenbrand <david@kernel.org>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Igor Mammedov
 <imammedo@redhat.com>, Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <b2b1d77e-c3e3-4aad-87d2-f5d4834abd1a@oss.qualcomm.com>
 <apAG8JQTnQxRkfip@redhat.com>
 <9e36f8a0-5363-4ce2-accf-62ccf3602344@oss.qualcomm.com>
 <CABgObfYw8U6q1xdUXcP5XBNTpB-n9MR=DkzFXpb6nkn7g00etQ@mail.gmail.com>
 <997fad72-3d6f-4ec6-9017-290959d9848f@oss.qualcomm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <997fad72-3d6f-4ec6-9017-290959d9848f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/27/26 21:58, Pierrick Bouvier wrote:
> On 8/27/2026 10:48 AM, Paolo Bonzini wrote:
>> Whoa whoa.
>>
> 
> I apologize to Daniel, and other people on this thread for resorting to
> sarcasm in this situation, and personally mention Daniel in my answer.
> 
> It stems from the fact that it's not the first time Daniel come on a
> thread to push a view (that might be wrong) and don't listen to other's
> people opinion, or leave the conversation when he has no more arguments
> or discover he's wrong. I'm not the first one to discover this, and it's
> a topic that came from multiple people I met. I invite anyone to tell me
> publicly it's in my head, and that it is wrong.

Please stop.  Just stop.  "It came from multiple people" never ends well.

I have my own disagreements with Daniel, which is no surprise since I've 
known him at work for over 15 years.  In fact, we probably had a couple 
just this week, though that's fortunately above average.  We have 
different personalities, we come from different cultural backgrounds. 
We are still able to respect each other and I seek his opinion even if 
(or sometimes because) I know it'll be different and make things harder 
for me. :)

>> Sometimes people don't reply not because they disagree, but because
>> they trust the people involved to resolve the problem.
> 
> We presented a plan a year ago, for which multiple people have been
> supportive in general. Now we are close to having a single binary
> upstream, we have Daniel coming last minute and asking to solve issues
> we are not at yet. I feel it's not helping us, and simply blocking work.
> 
> Daniel's main concern (correct me if I'm wrong), is that we might
> introduce regressions by introducing a -target option, and filtering on
> QOM types.

I'll briefly touch the technical part.  As it was explained, the problem 
is really just in the use of symlinks for aarch64 and riscv64 binaries.

All that Daniel is *asking for* is to split the experimental part from 
the existing one.  Did he go on a tangent on what else he'd like from 
the experimental part?  Yes, but that's simply a justification for why 
it's better to keep it split.

> I have no problem with anyone deciding to refactor the QEMU command
> line, but it's a different problem from what we are doing now.
> We just want to provide a first version upstream mixing at least two
> base architectures, and providing exact same behavior than existing
> binaries.

Yes, and that's fine.

>> Let me remind you of the discussion we had about -fms-bitfields and
>> how it was resolved amicably and profitably.
> 
> I really appreciated this exchange with you. Even if I was a newcomer,
> you explained where you disagreed, but accepted a different answer. Then
> we iterated to prove that existing struct layout were not impacted, and
> we both observed it was safe to remove this option. I felt like we both
> worked toward a goal, and not that you pushed your personal vision
> without any technical basis.

I have a different memory.  While I am also satisfied with the outcome, 
I remember that it was hard to explain why you couldn't just drop 
-fms-bitfields, and what analysis was required before you did that.  And 
the outcome was positive mostly (or only) because *I* did the analysis 
that was necessary to ensure there would be no regressions with *your* 
proposed patch.

What Daniel is asking is even less - he's only asking to *remove* the 
bits that symlink qemu-system-arm and qemu-system-riscv64 into 
qemu-system.  (Perhaps you could do that with a configure option 
instead, btw, that's also a possibility and would make CI integration 
easier).
>> This project was extremely complex and some disagreements are normal,
>> but overall I would say it has received support from the community for
>> years. It is close to the finish line, let's not forget all the
>> collaboration so far.
> 
> At this point, I don't see the finish line coming anytime soon.
> We are stuck in a situation where we now might have to design a whole
> new command line from scratch, for a reason I ignore.

This is simply not true. The important part: "We don't have to do all 
that straightaway. If we declare qemu-system 'experimental' initially we 
can iterate on that intentionally breaking compat in releases, without 
any impact on qemu-system-$TARGET".

Experimental doesn't mean unusable.
> - let's go with original plan, and just introduce -target option and
> call it a day for now. CLI refactoring can be initiated in parallel.

That's exactly what Daniel suggested.  In fact the same is true for more 
things than just the command line:

- filtering can be applied (if needed at all) to qemu-system *after* the 
binary is available in qemu.git, exactly because qemu-system is 
experimental;

- if we decide later that -target is not always needed, that would also 
be doable after the merge.

I hope this helps not so much solving the technical disagreement, but 
clarifying that yes, sometimes you've got to "agree to disagree", but 
personal attacks of any intensity are not "agreeing to disagree".

Paolo


