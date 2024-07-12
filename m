Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9238C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 08:51:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSBze-0007kY-EK; Fri, 12 Jul 2024 04:51:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSBzc-0007cZ-FC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:51:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sSBza-0003cJ-NZ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 04:51:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720774260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L5kyceAxXyZqcIxRAamUJLp8BO2co/1kbuTBzG3Kvuo=;
 b=TikFQ5giENEjwnouSx0eJ/YSIvLOecoItmlHzx0xRSn1B/2c8PEhVs4vwp6rKW4KlsnbOx
 0p+GbbwGEAXM/uU1mCpNTQisZAqxzvYw/+3AKRLK9LVpiiD/1kr1OOpYHzx++CPWWQIcbX
 /2xZCpDmg9dDyhMWcfQ5jbn4WeT65NY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-QjA-Ru4aOGO0Hr8oawhGkQ-1; Fri,
 12 Jul 2024 04:50:58 -0400
X-MC-Unique: QjA-Ru4aOGO0Hr8oawhGkQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1FB43195419C; Fri, 12 Jul 2024 08:50:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9F97319560AE; Fri, 12 Jul 2024 08:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 66F7921E668C; Fri, 12 Jul 2024 10:50:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Konstantin
 Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 04/14] qapi: add a 'command-features' pragma
In-Reply-To: <ZpDlizzbaXk4pa0U@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 12 Jul 2024 09:12:59 +0100")
References: <20240604153242.251334-1-berrange@redhat.com>
 <20240604153242.251334-5-berrange@redhat.com>
 <87r0bzuj7d.fsf@pond.sub.org> <ZpDlizzbaXk4pa0U@redhat.com>
Date: Fri, 12 Jul 2024 10:50:54 +0200
Message-ID: <87a5inuh75.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Jul 12, 2024 at 10:07:34AM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > The 'command-features' pragma allows for defining additional
>> > special features that are unique to a particular QAPI schema
>> > instance and its implementation.
>>=20
>> So far, we have special features (predefined, known to the generator and
>> treated specially), and normal features (user-defined, not known to the
>> generator).  You create a new kind in between: user-defined, not known
>> to the generator, yet treated specially (I guess?).  Hmm.
>>=20
>> Could you at least hint at indented use here?  What special treatment do
>> you have in mind?
>
> Essentially, these features are a way to attach metadata to commands that
> the server side impl can later query. This eliminates the need to hardcode
> lists of commands, such as in QGA which hardcodes a list of commands which
> are safe to use when filesystems are frozen. This is illustrated later in
> this series.

Please update docs/devel/qapi-code-gen.rst section "Pragma directives",
and maybe section "Features".

I'm not sure conflating the new kind of feature with existing special
features is a good idea.  I need to review more of the series before I
can make up my mind.


