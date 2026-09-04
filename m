Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F227C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 11:20:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2RxF-0007v4-14; Fri, 04 Sep 2026 07:19:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2RxD-0007up-3b
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:19:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x2RxB-0002gI-6B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 07:19:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788520767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GvUuFSXeFlt+byDdeSY+hjcL73fDoxIViCL8vW7C5xc=;
 b=DUIvmfUtfCaJb8dXTUkSwsq9RtVWiepIcLFM1PHj16OTRSgzAYASpOe9W+rq2KRUIJEie9
 Gx1q/Om0r0WxdP+P4dmU3n7EvTAwXwyeUcRtKNWOaDF+tthYtzIFz2FBpIAGD4/zov/OXS
 uciVNwW1sD3POk/41IZODFoJ/KX7LNw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-RYiK5e2iNZK61bnZ-zdiww-1; Fri,
 04 Sep 2026 07:19:24 -0400
X-MC-Unique: RYiK5e2iNZK61bnZ-zdiww-1
X-Mimecast-MFC-AGG-ID: RYiK5e2iNZK61bnZ-zdiww_1788520763
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C6ACF195DE2E; Fri,  4 Sep 2026 11:19:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2CC51180034C; Fri,  4 Sep 2026 11:19:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7A2F21E6A04; Fri, 04 Sep 2026 13:19:19 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  luoyonggang@gmail.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-devel@nongnu.org,  anjo@rev.ng,  Daniel Henrique Barboza
 <daniel.barboza@oss.qualcomm.com>,  philmd@oss.qualcomm.com,  Paolo
 Bonzini <pbonzini@redhat.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH 00/47] single-binary: implement dynamic filtering for
 QOM types
In-Reply-To: <apqVhJrtMDECUb7I@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 4 Sep 2026 10:55:16 +0100")
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <4b4f77ee-21e9-405e-a1da-21506afa1c5b@oss.qualcomm.com>
 <app_CnHimOrOymMH@redhat.com>
 <CAE2XoE9A1WzOe43-qd1v9i6K9kSru4R2kEE1-2TrztoM=8NZJw@mail.gmail.com>
 <CAFEAcA_4TZxYhFbHfJZCas7bvh_KZjNp2aKzx3LPaXTQFuoQYQ@mail.gmail.com>
 <apqVhJrtMDECUb7I@redhat.com>
Date: Fri, 04 Sep 2026 13:19:19 +0200
Message-ID: <87h5k58ds8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> Currently the QOM type name is directly derived from the machine
> type name, just with a "-machine" suffix attached. So if the
> machine name is not unique, then neither is the QOM type name.
>
> At the very least we need the QOM type name to be unique. We
> could de-couple the two to make this work though, which does
> not seem too hard.

[...]

> We don't have many examples of clashing machine names. Is there
> any beyond just the 'virt' boards ? Now that we know we want
> globally unique names, this feels easy enough to spot during
> review.

I checked -machine help for all qemu-system-T, and it seems to be just
"none", "virt" and "virt-VERSION", not counting duplicates between
architecture variants such as aarch64 and arm, x86_64 and i386, and so
forth.

>> This rests on the assumption that the only thing we need to
>> disambiguate is machine names, i.e. there aren't multiple
>> targets with user-facing (i.e. not easily renameable) device
>> names that are shared.
>
> IMHO it is best if our goal is to ensure type names are unique
> throughout the codebase, so hopefully we don't have clashing
> device names.

Yes.

Quick glance at type_new():

    if (type_table_lookup(info->name) !=3D NULL) {
        fprintf(stderr, "Registering `%s' which already exists\n", info->na=
me);
        abort();
    }

If we have duplicate type names, they won't survive being linked
together in a single binary.


