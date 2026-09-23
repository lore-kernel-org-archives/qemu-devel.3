Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67E92C98302
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9Qej-0001OR-3c; Wed, 23 Sep 2026 13:21:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qdj-0000nW-5P
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:20:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x9Qdg-0002ft-Pq
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:20:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184010;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DqCoiyetJCiNXCm1ENnKql5Uq9D63xlELsxdyd41qe8=;
 b=Q1K+kbCYslv5bAmN64X2grkOECXzbdQVbhCAnQewvJFxC//0xnt2l5ML0nOk2my4q/391b
 F/uQ4PovLLTiZuAVt/Gmym80Szb2sub/TVHTYBaIADgseB2quB0i5LPOqPO+FcyQWgJcbZ
 TkPTczcDyJMZvydQ5Ak7q2DKPcl3IVY=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-TkL0RpqRN72Lsv2u44gPBw-1; Wed, 23 Sep 2026 13:19:56 -0400
X-MC-Unique: TkL0RpqRN72Lsv2u44gPBw-1
X-Mimecast-MFC-AGG-ID: TkL0RpqRN72Lsv2u44gPBw_1790183996
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-6713ebbca2dso1567735d50.2
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:19:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790183996; cv=none;
 d=google.com; s=arc-20260327;
 b=HwwR1crXKCW1Ulhab271Xn4S9cUyTnIJnsRhpgjGsg6cJNBlkIChxsnlhO/j8XzkKP
 edU8ou6a2caVrrM+fJITva8vmImhAqwudRK2rVZ5S0w2M2t3oFW23Kbict0jMR7K3iM0
 IrCh8/rzNdd4AP8TTKTp1B32FS84B9DwgQ7WT5+bCCNqCh4Qr4m/gTgU+h+Cl4RSU6vr
 WXXfbuk2umCe82Vw9jV1351N7a4LTTEHX/4ADr1QBV0YCQF03OCMUBzJhPdbPgJiI0mt
 QhysXn2OoXLOkU6Svd+GRACDFUzW9fOmLMQV+DGeLYO0jiJrLraqfUyWhGx5vgh/Nd+k
 Xs7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=DqCoiyetJCiNXCm1ENnKql5Uq9D63xlELsxdyd41qe8=;
 fh=nv4lR2rH1aVW77dMNATQm0dxGI+JibghZG8DLCFB2GM=;
 b=lwxezQ2uWWOw1txkoUdvxkfQYsPbt4j12Vnvny/Un6UitibFL1Ib/HYe7k1tOHJMrd
 C7hlNL7oqVlYQaWJjERPHrWsStUWvMPXbj2qadqxcn/mRGAHR4lxQz75cfUvCHm/iFqV
 hgCEpqObNvreZnhKY+3NXUWd21E5vR+Dikj1Mgg3I3ZxIc/dZAbwzDusZesrGFAdLH/8
 JDzjrNZ+FUOJ6IEQMfuNncdB526rDtBVfZD6sPheQtZLwKa3Q+IYPdfiY1R03C1iwwZx
 L8YJ3pngazdnJApgAJqNPmMWs5YYUPxj6Hfcol2xNxiJ957gaqp9+Bl2NxyniM0P09tx
 HyVw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790183996; x=1790788796; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DqCoiyetJCiNXCm1ENnKql5Uq9D63xlELsxdyd41qe8=;
 b=JgFn5/EZ+21ku3VIFDUJdE9ty/ZOEXUzMABLWvrMwk918tZrV1MGYoxlqDlFlVcR7/
 GY3ld4ugSSH0JQBOGfV8wmQg/x9WlfIMbI2jB/iC1WNGmCpSKKj+1K36ms+tDRmN+prF
 cKbqYVYmPh+3k/J6JlccJx3roKVoSNQpLcWbaj/pMv9S8Hb/kRF6E65RyM+93Vkd4lQA
 237g1MubWRow+R6xMXtGVc7aDtK+szSSvFuLRWPMLYcdWw/CfFHV6PD3enTBlXRX62Ed
 TvM6mv4pQoHcUtYdjSDQKFR+a7rNz6RLDoHADeMABPMf95hvHt6pVjvb/jySYmAwnwf9
 CZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790183996; x=1790788796;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=DqCoiyetJCiNXCm1ENnKql5Uq9D63xlELsxdyd41qe8=;
 b=gSa32ZSyu2h2bafC5H9pQKa9nukGGj5MzTwfNefcO+LGEI07n2SSd8mtQIGEhvIG//
 WpcJgqEyoX+1EgPdSVLZD95eOWnF8cQaGy2mzbOp7oa+LwUH3kd08sC+Ge8XDp3O2F4X
 +aZUUGIJiCq1iWyX0ltQax1Y1aU/GebxVDP5dGv4H2nNl5qqDbza2gjI0SzILl+HCHtv
 eUmY9Rb1/9bUwQS4fKvfWesdeGUi4xQZD86Lk8l9aMN3iL6F323iPPRveqzMA2XdHq+p
 gMx8eU3y2JyPiJguI4fO4OIm5+wQ6nFZmjiW1bAIncU2xRcQs9NL2DeIO8m2PTI2UQSA
 JS9A==
X-Gm-Message-State: AFuF++kFxPP1LDRk9ZdchV56bS8Z6MnIvpRybhI755cO27qsSrZDuiRf
 N0Rnhlrfakhxb/fX4UwXgcjnuvgg+t0pNv7smzfEiUB1si4ibOWIKmpFtl0oXEGF0MPB8TqfRUq
 dXRI7LIDCRdRPnyGZBCf9wQ4obVbEfq805OI4CSI7U/tW5yU2eWUxy6lMezmyF6SL/K5VUxvTdG
 I+mQlKzLmafnw4To4NwyQSuq64rubAySMTo3s/cgM=
X-Gm-Gg: AYBFou3eAdWLUgYt2TSa4fqHdsum5L/CS1rjjtmVw332rdH3Da+O+I8Jq4A2xf+6OxX
 /IjzTI78a1TnJCLLWmoOcQGhsAlknsvJuJrIRBxQ6SYzxn1Ay4ziucLRK/qXb2D+iA4lzcDY6Z1
 mlDMv4T8fJNVLaEOgEDMj1sRhy1BuvbbvkvkSrPvdzxuYQiTECMdzAGalH6h78YjlqC/2DCacCk
 YtmZbRHk0k8BgWP
X-Received: by 2002:a05:690e:4553:10b0:672:99e1:11e0 with SMTP id
 956f58d0204a3-672d591dbaemr1140894d50.125.1790183996061; 
 Wed, 23 Sep 2026 10:19:56 -0700 (PDT)
X-Received: by 2002:a05:690e:4553:10b0:672:99e1:11e0 with SMTP id
 956f58d0204a3-672d591dbaemr1140866d50.125.1790183995662; Wed, 23 Sep 2026
 10:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260922205605.501602-1-jsnow@redhat.com>
 <8733v0zcsm.fsf@pond.sub.org> <87jyocxy0p.fsf@pond.sub.org>
In-Reply-To: <87jyocxy0p.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Wed, 23 Sep 2026 13:19:44 -0400
X-Gm-Features: AclHuK_ze6zfAffM4QDcVLsXj-18mpNU7S_ok6e6QdEQjIS1oEE6AWyizU-z2qE
Message-ID: <CAFn=p-bjeCtgY0Jr47P0czwKBeB6xv6YCR_S8PU65wH59hdrtg@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] qapi: convert intros for qga, firmware, etc
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 qemu-block@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Sep 23, 2026 at 2:49=E2=80=AFAM Markus Armbruster <armbru@redhat.co=
m> wrote:
>
> Markus Armbruster <armbru@redhat.com> writes:
>
> > Series
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
>
> With the update to tests/qapi-schema/doc-good.txt squashed into PATCH 2,
> of course.  I'll also make the commit message tweak for PATCH 5 if you
> like it.

Yes, please!


