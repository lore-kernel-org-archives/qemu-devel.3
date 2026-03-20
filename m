Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2D11099B33
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 18:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3eXS-0008Fx-4I; Fri, 20 Mar 2026 14:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eXM-0008ES-1A
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w3eXI-0004y5-5j
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 14:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774031126;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UDcrKbbbj3lnDzRnlmYOS81RXXLdG1E/NKywAcBlJa8=;
 b=f20kK82u4bqFUrmEA67ohsj1+A05h/MmjWwfBnpoBpkDIvda2QVopsr6RDxb1iOskMna3p
 HTqAeWhapkyVHzUjDPHUOKHLEfjEYY2Ii1OsnFYRv8avZ9LyhtqxAQx2oX5gOL5DxXGjgB
 0CJg7H00hg3DpyMPnNCJoLXFlxelCC4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-wJhihJrZPbSFZaVFcx7DLg-1; Fri, 20 Mar 2026 14:25:25 -0400
X-MC-Unique: wJhihJrZPbSFZaVFcx7DLg-1
X-Mimecast-MFC-AGG-ID: wJhihJrZPbSFZaVFcx7DLg_1774031125
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5093025ffecso109177081cf.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 11:25:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774031125; cv=none;
 d=google.com; s=arc-20240605;
 b=FxLGQyezfcY5mjuZHDpTIK18Uuthuu5naR1kKVXtBpjKiobCVKZ06sAv9dzzebh0AF
 MCeMqThjDXsferZW1G1whbjZNNPKQwZfOsMHvcyCS8336OU1lfap8tQV7nYZ37M6nC86
 jVWs4OlSG8Qgo7/oAXGJVBXO7xdTILg0zDmtMPZLJMi6uoqn84czNxiHNP11LEvkw1Ku
 qH0ZWPo5gnqLRaL9PY/hwYImDWmloNSZIu/56LK3giVSXLWrM5M1IPt9xVM5p+gM0AOI
 kKAdV/w0EzPtJsxumMddEkhhJN7vpk33nQvvIIeeDCke7b77eoRKWJJ/6O0gKfpIThMx
 3tqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UDcrKbbbj3lnDzRnlmYOS81RXXLdG1E/NKywAcBlJa8=;
 fh=ITVUHrDuK24wfFWcPHAMT7QsL3mgm65a7A/rtIt/55A=;
 b=MfboeSyl/wgCSrENtI0usxql9+I3R4sko9EMe3QEydWfgL99jCPDpRYtQ5ZXjetAf6
 4irGafZF3hR2J4URBqYt0izKFJrnrCEv28F4h5A8FUw8VXaw+8nHLHQjtaPdC31X8fUE
 77CgyAlkVbDRJvufgbRVPQpLQkMWpH/kYBLBUOtbzc2DSq78SBCeqHJTA2ArZNK6SSo5
 l+srjASZazFYnMFZV22nylKCzTjhKRXBDuQvHz1vwUaFDjmBAajn3exJcZZet2cDNqNu
 LKT+yu910j6ZrradpaT3x5IMEVGhCyFE6Rfj326hwaoECi0sU6yNpCm5YYKEkQpfyT+U
 HvBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774031125; x=1774635925; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UDcrKbbbj3lnDzRnlmYOS81RXXLdG1E/NKywAcBlJa8=;
 b=dOdSMNkGpi9fsLqseOHu3T7YM6/IgDAvxJSVsl1QEd3gtYrQtJmgVKo8n3B8XdmUQY
 flp2strXna8gMAN0y7VR8Owrxs2e8gApFyDl6sVKHhiAeTPAmUhPLnsmIniXSvDvpO40
 Tu3aLokkfm+aBPAKBfObeC4Qftnrj3J2CLHc55ZtvIQ2YGsBC2oiWoG4ZR5W1xgr+H0n
 ZYALsqa5hbn9+YKscvAG24wZbudgZ5PVf8kLYlfbk5nY4qtLo69CKWf0rORxEZJWXLsn
 RYn7mmLgiTc4aRW9hQg7KJqble+lHhhouAWvpwW8lSXJWGNgDvZ2mBZj3BReTG/KzbA0
 dk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774031125; x=1774635925;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDcrKbbbj3lnDzRnlmYOS81RXXLdG1E/NKywAcBlJa8=;
 b=V9Sl8Nvk3FJUVga+q/c5S36A6psTzftOt7XH8TkI5u6jLeifnXtbQdr8zm77In6KQu
 16+uW3MMcsV4Yg2u5eYwVLaczBaVXHiVdOgGqnduMJmPYIr4nwHw/xEhgLrSoRJqqeGp
 jDdHh3dCFnl3JnhRo26jCxJ5ssfOf/GyPjevAWxOXaX0fpL+vJqiL2b9I2Kwl/5+tGUW
 SSw0ab/pEkBbE9pN8pJf8IchoGjIEXAuinU3cOjLsGJpDPDLwjVR9LBEGOcHvM9MW/xk
 AgRV/WLuCAdAyPq3RAVyGPkyRqlUOkAMv46+xldwuqYhygry0YmZjnxykWYQOHV/xu7l
 iETA==
X-Gm-Message-State: AOJu0YyD/eQapFRQIa27voKf6tpP7mZjLJxMNMBQW8eCvpwe61ZCQFTn
 FsxxE4Vi89oiiBjyLmRiT4eavNTcvu6XPHzoz0/ufxH2OVQioKvmU/9BX45xPWssUEDYxGaec+Y
 E0WLcRuClZOCJKEdbR3Wb5KSYJ4kVqjljD0eSOudUkKi1Y2HGxcrTK4XdKzyKJCThyH5lyDWMUU
 8b9qMZU1U1waZ8JdMaVdeXtvJfihExKEo=
X-Gm-Gg: ATEYQzzlG9x1yeyuM1NcLZ5v3wCO2lXXPhssZtjGJ9oFK1DjNZcM+NbdOWDRCySkzGZ
 +WpXVjNx80FqYNsRvp+XJaJnylcyBuNOSY3ZZACyMvYVCANxeCR4O7Xm0bIDxvTp+T2oAt9xQA4
 g8a2H2drQ9WVaPc2GMTrHkx2BgeRiaUn0d3Zm7CmRXVhfy0EGxMp8ORSlNTqH+QtT7zJQE4LpZT
 x3beV2i3BI8lnZyE7LcvU/M4pBCVM9i5HO8sQ==
X-Received: by 2002:ac8:7e86:0:b0:50b:404a:745e with SMTP id
 d75a77b69052e-50b404a799emr32819581cf.49.1774031124422; 
 Fri, 20 Mar 2026 11:25:24 -0700 (PDT)
X-Received: by 2002:ac8:7e86:0:b0:50b:404a:745e with SMTP id
 d75a77b69052e-50b404a799emr32818841cf.49.1774031123777; Fri, 20 Mar 2026
 11:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260316182608.148628-1-jsnow@redhat.com>
 <20260316182608.148628-4-jsnow@redhat.com>
 <87tsua62cz.fsf@pond.sub.org>
In-Reply-To: <87tsua62cz.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Fri, 20 Mar 2026 14:25:11 -0400
X-Gm-Features: AaiRm50Q0OVrzoCXiVd1-tmNDZ1ApzDx5ZIS28jidXkP92Wo5GL-sLfXRTfR_1g
Message-ID: <CAFn=p-ZQicGi2CxNsKpk09mvC=KUhDnHnPTb878tKCj_RJiidA@mail.gmail.com>
Subject: Re: [PATCH 3/8] qapi: add "Details:" disambiguation marker
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Qemu-block <qemu-block@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Kevin Wolf <kwolf@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, 
 Yanan Wang <wangyanan55@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Kashyap Chamarthy <kchamart@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000f4248d064d78ce80"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_PASS=-0.001,
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

--000000000000f4248d064d78ce80
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026, 9:45=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > When a documentation block consists only of plaintext, there is nothing
> > to semantically differentiate the "intro" from the "details"
> > section. For the purposes of the inliner, the intro section is likely t=
o
> > be dropped while the details section will be merged onto the end of the
> > parent's details section.
> >
> > When the delineation between "intro" and "details" is not clear because
> > there is no intervening "members", "features", "errors", "returns",
> > "TODO", or "Since" section, the parser assumes the entire text section
> > is an "intro" section. This may not always be semantically true, so thi=
s
> > patch clarifies certain sections explicitly as "details" sections by
> > using an empty "Details:" marker.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > ---
> >  qapi/block-core.json   | 3 +++
> >  qapi/machine.json      | 2 +-
> >  qapi/migration.json    | 8 ++++++--
> >  qapi/net.json          | 2 +-
> >  qapi/qom.json          | 4 ++++
> >  qapi/yank.json         | 2 +-
> >  scripts/qapi/parser.py | 8 ++++++++
> >  7 files changed, 24 insertions(+), 5 deletions(-)
>
> Missing: update to docs/devel/qapi-code-gen.rst.  Suggest to put in a
> FIXME, so we don't forget.
>

ACK


> >
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index f8d446b3d6e..c5ff15ae7a1 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -5007,6 +5007,9 @@
> >  # @blockdev-reopen:
> >  #
> >  # Reopens one or more block devices using the given set of options.
> > +#
> > +# Details:
> > +#
> >  # Any option not specified will be reset to its default value
> >  # regardless of its previous status.  If an option cannot be changed
> >  # or a particular driver does not support reopening then the command
>
> Rendered documentation before the patch:
>
>     Command blockdev-reopen (Since: 6.1)
>
>        Reopens one or more block devices using the given set of options.
>        Any option not specified will be reset to its default value
>        regardless of its previous status.  If an option cannot be changed
>        or a particular driver does not support reopening then the command
>        will return an error.  All devices in the list are reopened in one
>        transaction, so if one of them fails then the whole transaction is
>        cancelled.
>
>        [...]
>
>        Unlike with "blockdev-add", the "backing" option must always be
>        present unless the node being reopened does not have a backing fil=
e
>        and its image does not have a default backing file name as part of
>        its metadata.
>
>        Arguments:
>           * options ([BlockdevOptions]) -- Not documented
>
> The command's single argument is undocumented, and the doc generator
> papered over this (sadly common defect) by splicing in this "Not
> documented" description.
>
> Aside: why not boxed, like blockdev-add?  Design mistake?
>
> The patch moves the splice point.  Not wrong, but we should really fill
> in the document gap instead.
>

Sure, but I'm worried about other things for the time being. I don't
disagree but I think I'm the wrong person for intricate doc cleanup work of
that sort.


> > diff --git a/qapi/machine.json b/qapi/machine.json
> > index 685e4e29b87..bc2279b2526 100644
> > --- a/qapi/machine.json
> > +++ b/qapi/machine.json
> > @@ -1259,7 +1259,7 @@
> >  # Return the amount of initially allocated and present hotpluggable
> >  # (if enabled) memory in bytes.
> >  #
> > -# TODO: This line is a hack to separate the example from the body
> > +# Details:
>
> This replaces a hack by a proper solution.  More of the same below, not
> mentioning this again.
>
> >  #
> >  # .. qmp-example::
> >  #
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index 7134d4ce47e..558b4f145ed 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -1633,7 +1633,7 @@
> >  #
> >  # Query replication status while the vm is running.
> >  #
> > -# TODO: This line is a hack to separate the example from the body
> > +# Details:
> >  #
> >  # .. qmp-example::
> >  #
> > @@ -1651,6 +1651,8 @@
> >  #
> >  # Xen uses this command to notify replication to trigger a checkpoint.
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "xen-colo-do-checkpoint" }
>
> No change to generated documentation.  I guess this is needed to avoid
> the yelping added in the next patch.  Correct?
>

Yes, probably. I didn't differentiate the cases...


> > @@ -1687,7 +1689,7 @@
> >  #
> >  # Query COLO status while the vm is running.
> >  #
> > -# TODO: This line is a hack to separate the example from the body
> > +# Details:
> >  #
> >  # .. qmp-example::
> >  #
> > @@ -1724,6 +1726,8 @@
> >  #
> >  # Pause a migration.  Currently it only supports postcopy.
> >  #
> > +# Details:
> > +#
> >  # .. qmp-example::
> >  #
> >  #     -> { "execute": "migrate-pause" }
>
> Likewise?
>
> > diff --git a/qapi/net.json b/qapi/net.json
> > index 118bd349651..c011d6dc1a9 100644
> > --- a/qapi/net.json
> > +++ b/qapi/net.json
> > @@ -1070,7 +1070,7 @@
> >  # switches.  This can be useful when network bonds fail-over the
> >  # active slave.
> >  #
> > -# TODO: This line is a hack to separate the example from the body
> > +# Details:
> >  #
> >  # .. qmp-example::
> >  #
> > diff --git a/qapi/qom.json b/qapi/qom.json
> > index 1b47abd44e9..568b7d4b997 100644
> > --- a/qapi/qom.json
> > +++ b/qapi/qom.json
> > @@ -777,6 +777,8 @@
> >  #
> >  # Properties for memory-backend-shm objects.
> >  #
> > +# Details:
> > +#
> >  # This memory backend supports only shared memory, which is the
> >  # default.
> >  #
>
> Rendered documentation changes from
>
>     Object MemoryBackendShmProperties (Since: 9.1)
>         Availability: CONFIG_POSIX
>
>        Properties for memory-backend-shm objects.
>
>        This memory backend supports only shared memory, which is the
>        default.
>
>        Members:
>           * The members of MemoryBackendProperties.
>
> to
>
>     Object MemoryBackendShmProperties (Since: 9.1)
>         Availability: CONFIG_POSIX
>
>        Properties for memory-backend-shm objects.
>
>        Members:
>           * The members of MemoryBackendProperties.
>
>        This memory backend supports only shared memory, which is the
>        default.
>
> Feels like a wash.
>
> I guess we need a "Details:" somewhere to avoid yelping.  Correct?
>

If we choose to formally include the yelper patch. I included it to show
all of the cases where this *might* make a difference.

There's likely other heuristics we could employ to reduce how often we
yelp. For instance, things that are never inlined from, or never inline,
could likely be skipped as it won't make a difference.

I think the trick here is to come up with a blanket "rule" that makes sense
and is easy to understand for the uninitiated, even if that rule covers
more cases than strictly necessary.

This patch used a very broad algorithm with almost no edge cases to yelp.

Concern: if I do not make the parser yelp, we may see new cases added in
the future that render in unintended ways. If I make the yelper too yelpy,
it's just annoying without providing sufficient benefit.

Truth is likely in the middle somewhere. This patch is an effort to find
and flush out that truth by brute force.


> > @@ -792,6 +794,8 @@
> >  #
> >  # Properties for memory-backend-epc objects.
> >  #
> > +# Details:
> > +#
> >  # The @merge boolean option is false by default with epc
> >  #
> >  # The @dump boolean option is false by default with epc
>
> Similar change to rendered documentation, same request to confirm
> yelping.
>
> > diff --git a/qapi/yank.json b/qapi/yank.json
> > index f3cd5c15d60..2854a8a9d2a 100644
> > --- a/qapi/yank.json
> > +++ b/qapi/yank.json
> > @@ -104,7 +104,7 @@
> >  #
> >  # Query yank instances.  See `YankInstance` for more information.
> >  #
> > -# TODO: This line is a hack to separate the example from the body
> > +# Details:
> >  #
> >  # .. qmp-example::
> >  #
>
> [Skipping the Python code in my first pass...]
>
> I'd be tempted to split the patch into hack replacement and yelping
> avoidance.
>

ACK, I can do that. It will take a moment to audit which cause real html
output changes and which are solely yelp avoidance, but it can be done.

Note that some changes may appear to be yelp avoidance only without the
inliner active. Some cases *may* produce tangible differences with the
inliner active.

I don't have an example at hand or a method currently to identify them,
it's just a heads up for the possibility.

>

--000000000000f4248d064d78ce80
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 20, 2026, 9:45=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; When a documentation block consists only of plaintext, there is nothin=
g<br>
&gt; to semantically differentiate the &quot;intro&quot; from the &quot;det=
ails&quot;<br>
&gt; section. For the purposes of the inliner, the intro section is likely =
to<br>
&gt; be dropped while the details section will be merged onto the end of th=
e<br>
&gt; parent&#39;s details section.<br>
&gt;<br>
&gt; When the delineation between &quot;intro&quot; and &quot;details&quot;=
 is not clear because<br>
&gt; there is no intervening &quot;members&quot;, &quot;features&quot;, &qu=
ot;errors&quot;, &quot;returns&quot;,<br>
&gt; &quot;TODO&quot;, or &quot;Since&quot; section, the parser assumes the=
 entire text section<br>
&gt; is an &quot;intro&quot; section. This may not always be semantically t=
rue, so this<br>
&gt; patch clarifies certain sections explicitly as &quot;details&quot; sec=
tions by<br>
&gt; using an empty &quot;Details:&quot; marker.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 qapi/block-core.json=C2=A0 =C2=A0| 3 +++<br>
&gt;=C2=A0 qapi/machine.json=C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/migration.json=C2=A0 =C2=A0 | 8 ++++++--<br>
&gt;=C2=A0 qapi/net.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 2 +-<br>
&gt;=C2=A0 qapi/qom.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 4 ++++<br>
&gt;=C2=A0 qapi/yank.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-<br>
&gt;=C2=A0 scripts/qapi/parser.py | 8 ++++++++<br>
&gt;=C2=A0 7 files changed, 24 insertions(+), 5 deletions(-)<br>
<br>
Missing: update to docs/devel/qapi-code-gen.rst.=C2=A0 Suggest to put in a<=
br>
FIXME, so we don&#39;t forget.<br></blockquote></div></div><div dir=3D"auto=
"><br></div><div dir=3D"auto">ACK</div><div dir=3D"auto"><br></div><div dir=
=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">
<br>
&gt;<br>
&gt; diff --git a/qapi/block-core.json b/qapi/block-core.json<br>
&gt; index f8d446b3d6e..c5ff15ae7a1 100644<br>
&gt; --- a/qapi/block-core.json<br>
&gt; +++ b/qapi/block-core.json<br>
&gt; @@ -5007,6 +5007,9 @@<br>
&gt;=C2=A0 # @blockdev-reopen:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Reopens one or more block devices using the given set of optio=
ns.<br>
&gt; +#<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # Any option not specified will be reset to its default value<br=
>
&gt;=C2=A0 # regardless of its previous status.=C2=A0 If an option cannot b=
e changed<br>
&gt;=C2=A0 # or a particular driver does not support reopening then the com=
mand<br>
<br>
Rendered documentation before the patch:<br>
<br>
=C2=A0 =C2=A0 Command blockdev-reopen (Since: 6.1)<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Reopens one or more block devices using the give=
n set of options.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Any option not specified will be reset to its de=
fault value<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0regardless of its previous status.=C2=A0 If an o=
ption cannot be changed<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0or a particular driver does not support reopenin=
g then the command<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0will return an error.=C2=A0 All devices in the l=
ist are reopened in one<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0transaction, so if one of them fails then the wh=
ole transaction is<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0cancelled.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0[...]<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Unlike with &quot;blockdev-add&quot;, the &quot;=
backing&quot; option must always be<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0present unless the node being reopened does not =
have a backing file<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0and its image does not have a default backing fi=
le name as part of<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0its metadata.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Arguments:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * options ([BlockdevOptions]) -- Not doc=
umented<br>
<br>
The command&#39;s single argument is undocumented, and the doc generator<br=
>
papered over this (sadly common defect) by splicing in this &quot;Not<br>
documented&quot; description.<br>
<br>
Aside: why not boxed, like blockdev-add?=C2=A0 Design mistake?<br>
<br>
The patch moves the splice point.=C2=A0 Not wrong, but we should really fil=
l<br>
in the document gap instead.<br></blockquote></div></div><div dir=3D"auto">=
<br></div><div dir=3D"auto">Sure, but I&#39;m worried about other things fo=
r the time being. I don&#39;t disagree but I think I&#39;m the wrong person=
 for intricate doc cleanup work of that sort.</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt; diff --git a/qapi/machine.json b/qapi/machine.json<br>
&gt; index 685e4e29b87..bc2279b2526 100644<br>
&gt; --- a/qapi/machine.json<br>
&gt; +++ b/qapi/machine.json<br>
&gt; @@ -1259,7 +1259,7 @@<br>
&gt;=C2=A0 # Return the amount of initially allocated and present hotplugga=
ble<br>
&gt;=C2=A0 # (if enabled) memory in bytes.<br>
&gt;=C2=A0 #<br>
&gt; -# TODO: This line is a hack to separate the example from the body<br>
&gt; +# Details:<br>
<br>
This replaces a hack by a proper solution.=C2=A0 More of the same below, no=
t<br>
mentioning this again.<br>
<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/migration.json b/qapi/migration.json<br>
&gt; index 7134d4ce47e..558b4f145ed 100644<br>
&gt; --- a/qapi/migration.json<br>
&gt; +++ b/qapi/migration.json<br>
&gt; @@ -1633,7 +1633,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Query replication status while the vm is running.<br>
&gt;=C2=A0 #<br>
&gt; -# TODO: This line is a hack to separate the example from the body<br>
&gt; +# Details:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt; @@ -1651,6 +1651,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Xen uses this command to notify replication to trigger a check=
point.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;xen-colo=
-do-checkpoint&quot; }<br>
<br>
No change to generated documentation.=C2=A0 I guess this is needed to avoid=
<br>
the yelping added in the next patch.=C2=A0 Correct?<br></blockquote></div><=
/div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, probably. I didn&#3=
9;t differentiate the cases...</div><div dir=3D"auto"><br></div><div dir=3D=
"auto"><div class=3D"gmail_quote gmail_quote_container"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<br>
&gt; @@ -1687,7 +1689,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Query COLO status while the vm is running.<br>
&gt;=C2=A0 #<br>
&gt; -# TODO: This line is a hack to separate the example from the body<br>
&gt; +# Details:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt; @@ -1724,6 +1726,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Pause a migration.=C2=A0 Currently it only supports postcopy.<=
br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 #=C2=A0 =C2=A0 =C2=A0-&gt; { &quot;execute&quot;: &quot;migrate-=
pause&quot; }<br>
<br>
Likewise?<br>
<br>
&gt; diff --git a/qapi/net.json b/qapi/net.json<br>
&gt; index 118bd349651..c011d6dc1a9 100644<br>
&gt; --- a/qapi/net.json<br>
&gt; +++ b/qapi/net.json<br>
&gt; @@ -1070,7 +1070,7 @@<br>
&gt;=C2=A0 # switches.=C2=A0 This can be useful when network bonds fail-ove=
r the<br>
&gt;=C2=A0 # active slave.<br>
&gt;=C2=A0 #<br>
&gt; -# TODO: This line is a hack to separate the example from the body<br>
&gt; +# Details:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
&gt; diff --git a/qapi/qom.json b/qapi/qom.json<br>
&gt; index 1b47abd44e9..568b7d4b997 100644<br>
&gt; --- a/qapi/qom.json<br>
&gt; +++ b/qapi/qom.json<br>
&gt; @@ -777,6 +777,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Properties for memory-backend-shm objects.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # This memory backend supports only shared memory, which is the<=
br>
&gt;=C2=A0 # default.<br>
&gt;=C2=A0 #<br>
<br>
Rendered documentation changes from<br>
<br>
=C2=A0 =C2=A0 Object MemoryBackendShmProperties (Since: 9.1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Availability: CONFIG_POSIX<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Properties for memory-backend-shm objects.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0This memory backend supports only shared memory,=
 which is the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0default.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Members:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The members of MemoryBackendProperties=
.<br>
<br>
to<br>
<br>
=C2=A0 =C2=A0 Object MemoryBackendShmProperties (Since: 9.1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Availability: CONFIG_POSIX<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Properties for memory-backend-shm objects.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0Members:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The members of MemoryBackendProperties=
.<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0This memory backend supports only shared memory,=
 which is the<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0default.<br>
<br>
Feels like a wash.<br>
<br>
I guess we need a &quot;Details:&quot; somewhere to avoid yelping.=C2=A0 Co=
rrect?<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"=
auto">If we choose to formally include the yelper patch. I included it to s=
how all of the cases where this *might* make a difference.</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">There&#39;s likely other heuristics we c=
ould employ to reduce how often we yelp. For instance, things that are neve=
r inlined from, or never inline, could likely be skipped as it won&#39;t ma=
ke a difference.</div><div dir=3D"auto"><br></div><div dir=3D"auto">I think=
 the trick here is to come up with a blanket &quot;rule&quot; that makes se=
nse and is easy to understand for the uninitiated, even if that rule covers=
 more cases than strictly necessary.</div><div dir=3D"auto"><br></div><div =
dir=3D"auto">This patch used a very broad algorithm with almost no edge cas=
es to yelp.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Concern: if =
I do not make the parser yelp, we may see new cases added in the future tha=
t render in unintended ways. If I make the yelper too yelpy, it&#39;s just =
annoying without providing sufficient benefit.</div><div dir=3D"auto"><br><=
/div><div dir=3D"auto">Truth is likely in the middle somewhere. This patch =
is an effort to find and flush out that truth by brute force.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote=
_container"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">
<br>
&gt; @@ -792,6 +794,8 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Properties for memory-backend-epc objects.<br>
&gt;=C2=A0 #<br>
&gt; +# Details:<br>
&gt; +#<br>
&gt;=C2=A0 # The @merge boolean option is false by default with epc<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # The @dump boolean option is false by default with epc<br>
<br>
Similar change to rendered documentation, same request to confirm<br>
yelping.<br>
<br>
&gt; diff --git a/qapi/yank.json b/qapi/yank.json<br>
&gt; index f3cd5c15d60..2854a8a9d2a 100644<br>
&gt; --- a/qapi/yank.json<br>
&gt; +++ b/qapi/yank.json<br>
&gt; @@ -104,7 +104,7 @@<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # Query yank instances.=C2=A0 See `YankInstance` for more inform=
ation.<br>
&gt;=C2=A0 #<br>
&gt; -# TODO: This line is a hack to separate the example from the body<br>
&gt; +# Details:<br>
&gt;=C2=A0 #<br>
&gt;=C2=A0 # .. qmp-example::<br>
&gt;=C2=A0 #<br>
<br>
[Skipping the Python code in my first pass...]<br>
<br>
I&#39;d be tempted to split the patch into hack replacement and yelping<br>
avoidance.<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=
=3D"auto">ACK, I can do that. It will take a moment to audit which cause re=
al html output changes and which are solely yelp avoidance, but it can be d=
one.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Note that some chan=
ges may appear to be yelp avoidance only without the inliner active. Some c=
ases *may* produce tangible differences with the inliner active.</div><div =
dir=3D"auto"><br></div><div dir=3D"auto">I don&#39;t have an example at han=
d or a method currently to identify them, it&#39;s just a heads up for the =
possibility.</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_c=
ontainer"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">
</blockquote></div></div></div>

--000000000000f4248d064d78ce80--


