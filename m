Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1A9C282DE
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqVFZ-00043x-6Y; Fri, 07 Mar 2025 05:48:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqVFL-00043E-DH
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:48:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tqVFJ-0001pE-FE
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741344478;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vDgxdIqyMPD+47whYzZC68qzegYABl5Wx1gPV99N9zw=;
 b=KFfWm1ZnHRPvw6Sjm0U+IAQMXnW5ryVESSRKOJFbNWZB+u9H9jI4IR6gTt8SNLQ4alSorp
 SljrpQvf4FvX0MWYIMB9ZmulNMvJ1tdxThuJSSSb3q0VmRbVPUQoi+3Ca7S2vYRPGN0Etb
 idnmM0bWRdSY/xtBXFWA1beK0Tn5HTg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-YSm8Rk5wMkKWgH_oeTspJA-1; Fri,
 07 Mar 2025 05:47:53 -0500
X-MC-Unique: YSm8Rk5wMkKWgH_oeTspJA-1
X-Mimecast-MFC-AGG-ID: YSm8Rk5wMkKWgH_oeTspJA_1741344472
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6C191801A07; Fri,  7 Mar 2025 10:47:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E7871956095; Fri,  7 Mar 2025 10:47:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A760721E675F; Fri, 07 Mar 2025 11:47:49 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Philippe =?utf-8?Q?Mat?=
 =?utf-8?Q?hieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>,  Thomas
 Huth <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,  Harmonie Snow <harmonie@gmail.com>
Subject: Re: [PATCH 21/57] docs/qapi-domain: add :deprecated: directive option
In-Reply-To: <20250305034610.960147-22-jsnow@redhat.com> (John Snow's message
 of "Tue, 4 Mar 2025 22:45:30 -0500")
References: <20250305034610.960147-1-jsnow@redhat.com>
 <20250305034610.960147-22-jsnow@redhat.com>
Date: Fri, 07 Mar 2025 11:47:49 +0100
Message-ID: <87plitm816.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> Although "deprecated" is a feature (and *will* appear in the features
> list), add a special :deprecated: option to generate an eye-catch that
> makes this information very hard to miss.
>
> (The intent is to modify qapidoc.py to add this option whenever it
> detects that the features list attached to a definition contains the
> "deprecated" entry.)

Let me explain it in my own words to make sure I understand.

1. The transmogrifier emits a :feat: for the feature like for any other.
   Therefore, the feature is rendered like any other.,

2. The transmogrifier additionally emits the owning directive with a
   :deprecated: option.  This gets the eye-catch rendered.

Example:

    Command drive-backup (Since: 1.6)
 -->    This command is deprecated.

       Start a point-in-time copy of a block device to a new destination.
       The status of ongoing drive-backup operations can be checked with
       query-block-jobs where the BlockJobInfo.type field has the value
       'backup'.  The operation can be stopped before it has completed
       using the block-job-cancel command.

       Arguments:
          * The members of "DriveBackup".

       Features:
 -->      * **deprecated** -- This command is deprecated.  Use "blockdev-
            backup" instead.

The first arrow marks the eye-catch.  The second marks the normally
rendered feature.

The eye-catch is redundant with the feature rendering.  Readers may
nevertheless find an eye-catch useful.

For what it's worth, the Python documentation has deprecation
information at the end of a definition documentation, together with
"changed in" information.  Both are colored to catch the eye.  More
restrained than your eye-catch.  Also uses less space.

Hmm.

Not a blocker.

> -
>
> RFC: Technically, this object-level option is un-needed and could be
> replaced with a standard content-level directive that e.g. qapidoc.py
> could insert at the beginning of the content block. I've done it here as
> an option to demonstrate how it would be possible to do.
>
> It's a matter of taste for "where" we feel like implementing it.
>
> One benefit of doing it this way is that we can create a single
> containing box to set CSS style options controlling the flow of multiple
> infoboxes. The other way to achieve that would be to create a directive
> that allows us to set multiple options instead, e.g.:
>
> .. qapi:infoboxes:: deprecated unstable
>
> or possibly:
>
> .. qapi:infoboxes::
>    :deprecated:
>    :unstable:
>
> For now, I've left these as top-level QAPI object options. "Hey, it works."

Do you intend to drop this part in the final version?

Having the commit message explain paths not taken can be useful.  But
this is phrased as an RFC, which suggests to me you plan to drop it.

> P.S., I outsourced the CSS ;)

Hi, Harmonie!

> Signed-off-by: Harmonie Snow <harmonie@gmail.com>
> Signed-off-by: John Snow <jsnow@redhat.com>


