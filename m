Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE5BFCA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 14:59:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZIh-0003yU-JX; Tue, 29 Sep 2026 10:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZIf-0003y1-RA
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBZIe-0004n7-CU
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 10:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790693959;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqQNJTixA8kN0oh0AmOlHcis6d0HHLkXX2BcFyuKAbM=;
 b=Aj7coIyhp6spLFFXpJ1GFrXZrk/hpjMu4QTUS7r8PEsQgPoLIva7ya2TZcwgfWESLfAT1t
 wIkhVX8bDHLxddqky1Fkdfw4h3YYKgVW6IbfnsWF9ljlYOQH7HReserJlt1Sinu9LpZ3RL
 xXzIPuZtYJDkw44Jdi9T4/eYIMPJFC4=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-A7Gy9wsDMtmGDf9HhD6UeQ-1; Tue, 29 Sep 2026 10:59:17 -0400
X-MC-Unique: A7Gy9wsDMtmGDf9HhD6UeQ-1
X-Mimecast-MFC-AGG-ID: A7Gy9wsDMtmGDf9HhD6UeQ_1790693957
Received: by mail-yx1-f71.google.com with SMTP id
 956f58d0204a3-675346c1d96so3969823d50.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 07:59:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790693957; cv=none;
 d=google.com; s=arc-20260327;
 b=TVKG73TEP7piS2IEsyyWL5Cua12hXeb2NjILvSTa0oUcpIX9cg2Te/1OAqX3gCcB4x
 Midh4TpCCIXIcn87jmsinL31YTUTs/PFPx1nSB3h4aPR2H68HUNNXEH20edYAjk1Ng9U
 jslDnkCmvdEA4QcB3ilPlsCHicOlVLldbqem2OmiNHoaLxbbT7mm9K26zqROLlcsYw5g
 xukF83OGRQ5FmdOgRK7+seZpusvzCyPUwkmO49Q00G/9QJ/BZMP1UG8/Rai8BQq9pL2H
 ulNYDdn5/cw1FF72evTWxtwHGG7TAlvjb/bny5C08eqlH+uiUgT4/St5zbbHn5YxFW11
 mWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=qqQNJTixA8kN0oh0AmOlHcis6d0HHLkXX2BcFyuKAbM=;
 fh=n+2DAFMZlHp3F1d4nio56yaatBOIj9xQxACGOxQdYUk=;
 b=Y/9C7SxS1EEa90Qqs/TE/4qQD3UpjOV10Yqh8zZThn3U3TuthW00nG6GHV2LXsGr1G
 I/AOr8H9D0fl8xKz3YRexaKtpamXtJW5TStoZ2g+ZL8vmlRCFD3CNLNUTY1Y2DzrayMS
 tSrUYeoYvlnI0M0sXwawaFD6bUhmFAAMlP/MrnRLGn7VMcylDZL83wUvCgQUI0OemBA/
 z+Cof69fq/+RXtpjagsQOJ4iBNxgU8JNB+sDOWYObqa/IMbgLBO3Dh8STlBv1sMmU+uL
 wW3nTCIyksx1boNOWhdjjJmr3PUE6tNwe2c/4PX44g/0P3w9a5xlCzKjso50f6Z+Wsb9
 zRtg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790693957; x=1791298757; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qqQNJTixA8kN0oh0AmOlHcis6d0HHLkXX2BcFyuKAbM=;
 b=S3nud+KvIiJZkv058a/0y4Gd0XKDyXkER2TFWUp5x8y+Tx8B8W6eRJma5QmxxHkSoi
 c+21DiwJvrbRbGxMOIFpwz2K4LuN8jpu3VXXvPUl3jP5hYXh3EBxW7J+y5IRY/ToSZTp
 zDdTPquh4ih4HvAyu7AzMnGaQewL/KVjpTr1NyotPYvAWDAauaNshNJmR3bNNFRRUyP2
 BUYHEpXtt7XPBEaHHy86ri/PVyyO/oV1guE+BDCFQBFZmoibr9kzhI4LqHctOcsP+c5o
 kHARxo/YYyc2L3Mnp3W2xTRljr3gC9xFq83v5u7g1wR5LdEjVaFpKqMiSGdSMQvXH27y
 9Qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790693957; x=1791298757;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qqQNJTixA8kN0oh0AmOlHcis6d0HHLkXX2BcFyuKAbM=;
 b=cOuXlJ+WxiEgHbH6fKUoCA/ZoE2F57r9W6Gd++Edi6ItbOnoHDoYE+2GKFoSSb8hYn
 Gz6B4l5Am3uWPDdUkU/MTVWA8MtEsKUflPKLauQE2CTK9ufwbCOkaQ4F5DvW2+6n0dZH
 VSGeLqPCcBVyYEtsValoOC/HchievGs6xorT4B+wNwkRVCL22mMsWOmH30RvABZEFR79
 ItWoxFYDUi7fM+nG3rSdGaAzHfAmt3spmWMDDCPHWHkJ3e/DLvhmAmoWOjQRZ06gUuoJ
 tJjmk0hRaidqdynuIwlAbPetFBZlfUqPLPjZhtN7nLIUMNq9SXZ2pCLdkg8sq+Yq2Ayj
 pU+A==
X-Gm-Message-State: AFuF++mpjLPkdBZtqo/h/rpU7cW9Hpe9JLoP7asgjIlkfCo+Zg5BjnS3
 SwgoCtq1c4sb8lpUhBB0OY6LpRy2+cxWqiYzTsNhgs4J3zCJ5+c1LSyO/eClzd/z5uFtrLLoxG+
 0F4YquUAmzOZgsqTeARIWsp+j7StkksOfTMZ1Htvbs6b1D603DDxb6hIrVxYE0bd4G74uuvYI+t
 XeASDE64UIIzy8HGOJbUKPI55GA60w5Xc=
X-Gm-Gg: AYBFou0jzCF+2H3BGW61u8pexFstAHI6e/qk1iV8XGoXJIiv8BQn54Gyc9z4fR+Q3Lz
 QKemcNDlNfTBB03JImO3pZ+QI20D2uPHMeXwagZ/s0zqHJTbszk5IU1jZaLf9K3mmUtbyp1/mrh
 jImM9jhsXXqcp0sQ/SPM7CYfwXFyrvJIGCP5fMjX2szQjAVzgCjZ+T9CgS0qtf8ZQtLZa04r229
 it+FZQSIoM+0sY=
X-Received: by 2002:a05:690e:b48:b0:675:3ce0:29bf with SMTP id
 956f58d0204a3-6753ce02dafmr3293396d50.34.1790693956675; 
 Tue, 29 Sep 2026 07:59:16 -0700 (PDT)
X-Received: by 2002:a05:690e:b48:b0:675:3ce0:29bf with SMTP id
 956f58d0204a3-6753ce02dafmr3293389d50.34.1790693956258; Tue, 29 Sep 2026
 07:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260928192557.509157-1-jsnow@redhat.com>
 <20260928192557.509157-4-jsnow@redhat.com>
 <87h5j837kv.fsf@pond.sub.org>
In-Reply-To: <87h5j837kv.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Tue, 29 Sep 2026 10:59:04 -0400
X-Gm-Features: AclHuK-KWOI1zcL_ePAM2xCU4btDO_KZYw4uZu2m8ONSdd_3oQjvIT_z-HvG1gk
Message-ID: <CAFn=p-YxNvecsdJGgtd=6A0ySxBL_F-ZQpkJzvbt6iBJ3B88cA@mail.gmail.com>
Subject: Re: [PATCH v3 03/10] qapi: convert/split intros for block commands
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Zhao Liu <zhao1.liu@intel.com>, 
 Igor Mammedov <imammedo@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jason Wang <jasowangio@gmail.com>, 
 Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Qemu-block <qemu-block@nongnu.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>
Content-Type: multipart/alternative; boundary="0000000000002a2778065ca06ddb"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

--0000000000002a2778065ca06ddb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026, 2:17=E2=80=AFAM Markus Armbruster <armbru@redhat.com>=
 wrote:

> John Snow <jsnow@redhat.com> writes:
>
> > Convert, or split off, intro sections for commands defined in
> > block.json and block-export.json. In general, this does not currently
>
> Suggest to scratch "In general".
>

ACK


> > impact the way these commands are rendered, except:
> >
> > 1. blockdev-open-tray and blockdev-close-tray see their opening
> >    paragraphs split apart, which is reflected in the rendered output,
> >    and
> >
> > 2. block_set_io_throttle and nbd-server-add see their argument
> >    definitions move up to just below the formalized introductory
> >    section.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
>
>

--0000000000002a2778065ca06ddb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Sep 29, 2026, 2:17=E2=80=
=AFAM Markus Armbruster &lt;<a href=3D"mailto:armbru@redhat.com">armbru@red=
hat.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">John Snow &l=
t;<a href=3D"mailto:jsnow@redhat.com" target=3D"_blank" rel=3D"noreferrer">=
jsnow@redhat.com</a>&gt; writes:<br>
<br>
&gt; Convert, or split off, intro sections for commands defined in<br>
&gt; block.json and block-export.json. In general, this does not currently<=
br>
<br>
Suggest to scratch &quot;In general&quot;.<br></blockquote></div></div><div=
 dir=3D"auto"><br></div><div dir=3D"auto">ACK</div><div dir=3D"auto"><br></=
div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_container"><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #c=
cc solid;padding-left:1ex">
<br>
&gt; impact the way these commands are rendered, except:<br>
&gt;<br>
&gt; 1. blockdev-open-tray and blockdev-close-tray see their opening<br>
&gt;=C2=A0 =C2=A0 paragraphs split apart, which is reflected in the rendere=
d output,<br>
&gt;=C2=A0 =C2=A0 and<br>
&gt;<br>
&gt; 2. block_set_io_throttle and nbd-server-add see their argument<br>
&gt;=C2=A0 =C2=A0 definitions move up to just below the formalized introduc=
tory<br>
&gt;=C2=A0 =C2=A0 section.<br>
&gt;<br>
&gt; Signed-off-by: John Snow &lt;<a href=3D"mailto:jsnow@redhat.com" targe=
t=3D"_blank" rel=3D"noreferrer">jsnow@redhat.com</a>&gt;<br>
<br>
</blockquote></div></div></div>

--0000000000002a2778065ca06ddb--


