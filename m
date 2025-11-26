Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EEB8D10F22
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 11:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vODz4-0005SD-3R; Wed, 26 Nov 2025 06:46:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vODz2-0005Rb-BX
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:46:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vODz0-0000vx-49
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 06:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764157608;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f5RVq/ZiJck4pwsMKwc+cQjuf6SQUng3Qa9qGks4MTY=;
 b=ik8Ao6h9UqfrnF/nDTdsgLHBFD9bl9OBVOtDB8t5Pl9cGSZnT/coqn9+FepGAnZqfm/TXo
 cjcyzhKKq/eQ/tN5WKSh3WFmAfXyNQeHGvOALHNQtQ7CPD5cIDjw7L6yfNPAOq40P0Zmuc
 xYIv9e0djajJ6CTHGOKZzS3zJtz0GsE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-324-iJQi230dMYq_Uiehc_Sq6Q-1; Wed,
 26 Nov 2025 06:46:44 -0500
X-MC-Unique: iJQi230dMYq_Uiehc_Sq6Q-1
X-Mimecast-MFC-AGG-ID: iJQi230dMYq_Uiehc_Sq6Q_1764157604
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99EE918011EF; Wed, 26 Nov 2025 11:46:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.3])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2295C195608E; Wed, 26 Nov 2025 11:46:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9446A21E6A27; Wed, 26 Nov 2025 12:46:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Peter Xu <peterx@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 qemu-devel@nongnu.org,  farosas@suse.de,  peter.maydell@linaro.org
Subject: Re: g_autoptr(Error)
In-Reply-To: <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 26 Nov 2025 11:26:20 +0100")
References: <20251125070554.2256181-1-armbru@redhat.com>
 <871plmk1bc.fsf@pond.sub.org> <aSWSLMi6ZhTCS_p2@redhat.com>
 <87jyzexrly.fsf@pond.sub.org> <aSXWKcjoIBK4LW59@x1.local>
 <769f5a57-7006-4cef-a5cb-12d53b7c30a5@redhat.com>
 <c0aa79ad-d6f4-413f-ade6-43e7609e37ac@redhat.com>
Date: Wed, 26 Nov 2025 12:46:40 +0100
Message-ID: <87ecplc8yn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> On 11/26/25 09:19, C=C3=A9dric Le Goater wrote:
>> On 11/25/25 17:15, Peter Xu wrote:
>>> On Tue, Nov 25, 2025 at 12:46:01PM +0100, Markus Armbruster wrote:

[...]

On the review and merging of commit 18eb55546a5 (error: define
g_autoptr() cleanup function for the Error type):

>>>> I missed it.=C2=A0 Not he submitter's fault; it was cc'ed to me.
>>>
>>> If someone to blame, it's the reviewer.
>> At end, I was the one who merged this stuff. My bad.
>>
>> I felt confident at the time, as it was only a single-line change review=
ed
>> by a subsystem maintainer and the patch was large enough that this didn't
>
> s/patch/series/ makes more sense.
>
> Sorry for the noise.

> C.
>
>
>> raise my attention.
>>
>> But it should have been treated with greater caution, global features mu=
st
>> be introduced together with concrete usage proposals. I think this would
>> have raised some unconscious red flags.
>> Thanks,
>> C.

Don't worry about it!  From my point of view, the process worked okay.
A big series got reviewed by maintainers, except for one little patch
touching another subsystem, where that subsystem's maintainer (me)
remained silent.  The series was then merged without further delay.

Would I have appreciate a timely nudge on that little patch?  Sure.  Is
not nudging me a failure of sorts?  Nope.


