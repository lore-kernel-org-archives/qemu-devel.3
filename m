Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D93ACD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:45:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZDFQ-0006Wr-0S; Mon, 15 Jun 2026 15:45:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wZDFO-0006W2-0U
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:45:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wZDFL-0004WL-GB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781552722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e9WP1c2EpAEG3hSuiAV0GYoU8NlzhyFLVwlwiKZyD8Q=;
 b=Y3a8N2r4OTLnGyiFJX7ZR1BR8FfW5wyh26Nn3vMvnRwkbWkDjywJR+MSnevLxmY4QoIpey
 rS2hlJQrgJufH1f7F/LV1mfHx6qc9QRyvQbxvkV4H4jT8dY0onksZSph4ESTI+IKpP1hQ8
 2dvmASj1jEURD912PhkhJIZj2u40YiY=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-RBihdHe9OsmHBcY6Xe2dcw-1; Mon, 15 Jun 2026 15:45:19 -0400
X-MC-Unique: RBihdHe9OsmHBcY6Xe2dcw-1
X-Mimecast-MFC-AGG-ID: RBihdHe9OsmHBcY6Xe2dcw_1781552719
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-66063190853so5813115d50.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:45:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781552719; cv=none;
 d=google.com; s=arc-20240605;
 b=ZDhadwYOOIGykOkjcGvxTiu1eMintUgvsGPcvA8p83uGTB0Gl7omx1mVAqHvJmQdEF
 WEJh1lovANQowhX2CGmXkOcVFgVgBXRT+JwWQNnF+UmnRpRG9JhK/PtPqM5fb/NKgfZ3
 5APh5UG5Fp4Q4f4l199VWvgbsjHRRFqHY4BIXRY6q4XMgCjM/ExNx/ccAo4oHQvCJX7Q
 FdORaK7iPzXNQ45mKkVOwMrOG4YbOLiLva9MXuj/xXv1PsbkzP0Yuy7xyvjihBYFFbdi
 d0fvTClUe6w+Qs3OPCB0PppfAS+/HLRp9X5uxh91eXKmBgF0VCW+fc9USyGIlHLDOfAH
 InLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=e9WP1c2EpAEG3hSuiAV0GYoU8NlzhyFLVwlwiKZyD8Q=;
 fh=Ohhlf+kwivs7jyQv9LUTHNY6pEAdnCK0uS2X5z9ZBdU=;
 b=JJCy9qcxTY3P189JQ5gCdyxPmb7xC85hdRidKzaLnUZIlf7CmYmgZ9sBp0DqmN2eKm
 fOYraPd0Z/iHkBBN9BITqzeQGyEIyuT+qZj387lHIZGjNtJzQkFYKZuBRsUdB8wW31n/
 i5vo20oJlSpdnuFR6x6p6M2YxxN+9aRYGxWqy3p41luIe4OrX82PbcwPL/0rSoVR80Go
 Ry6NYCo637HU8YTTcYFuyjBc1cSH80nWwR2sh8bJT5Sol1dQ52lA+7kzOkhsOyX+6r/U
 +QFpy2N+BuzP/v4xm/VYg/JB7jWVPJQP20evXilIfidk+eQnx+9QdPyGqYS4rTVa5GiO
 2Ykw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781552719; x=1782157519; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e9WP1c2EpAEG3hSuiAV0GYoU8NlzhyFLVwlwiKZyD8Q=;
 b=QvOi9GcAejsqCIf2XWOBW6ZhLCbLltATpZeL5rIBq52I9n/VL7SGBcuMHWXKn8Na5F
 YCxMHnWyA33SyT21XJBjy5MiAxkHNYWDAS16pE1vUaZVFkNEj0GNseAislj/UHx1ey+K
 ZXvVkOVyd0lRDyjjkqIFdz0ogdaWwURRdpLEw7t18/eUsBO34ARapx2C5g7Upwb5hJwP
 AAXiGsccSiRv3Oktmp9nVu4quFZrCUCzF6zYSigZKHdiGifY3IUHlBv2wsKKU44f4eE7
 aJIXss6tovGQzJKxWknlPb8jZjPF2rN9F1UcWKUzVO1gOlp/EBp0RizRfBhISwDpOcgb
 a/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552719; x=1782157519;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e9WP1c2EpAEG3hSuiAV0GYoU8NlzhyFLVwlwiKZyD8Q=;
 b=VEidA6MLJIB0SWGyOB4nwKSWTO2ssZupSzT/4l+BS6dT/u+drM26YaTn5a0LvMLm9s
 azUDNAVDH6hLdkuHBXly9w6fwUZraSJ78sNz/I4zUQyhzZXkO6deDvzhuc38zyL1eSWq
 A9q9+BTCBpMcN6eHkYZpMHsmAxjCk5yXLCW0rflVAtJNcJg4ws1b/6z7NR28R/2+Yjcx
 tXJhv8uYoHZji2J0auiAKS5TlLQcfH033Wn98bKAOlBnXYACpgDe/mCz8CDQFxcgAwiP
 InwWQuL42MRgCqnfeVnlER28o5N8TGTMUA3vR3oi5WjnYLWP8NQx25vqAukCKfcvxrZn
 rUtg==
X-Gm-Message-State: AOJu0Yw69bGAZ+1MNnxg+TbfSoiZI4EIrb2Mw02wMakaF/cIetewk3rV
 Cvvvcud9BFcdjQ5XdJ//cDPzcZUAA3WpuiC82I9Do22j4DgqGZLV25Vnx+IXRdekxxC4YCde0iM
 6LYSfdxshCEyutD63K7VTJitA0YQ2O3tIxZV7ajPvplyfgFH3QXoFtGsbuqVrILKGMKjCF1+5Hu
 1pW1OZFdCsswYilQT7KENIwtaW7t33ozo=
X-Gm-Gg: Acq92OHdqu70UnQ88oPEmbE6P34S9LJygn84mH/2JEWtggm8omRbODuTs/RBFSKrf7n
 fgkkXilkbqxRFn+biO2TE4CfLkwCS4mfxmMrw3xPlJCJFNbh5gYgVnxlwfOdNT4pDbZ+Lw4XvTo
 O6/DVZU7QQT0Kd3JU8RYctEUA8Yj6UV78X12FQiX/tyGsw+Zahw0Wx0dCs+wylJT20IO4Z62qKo
 xZOsdCBBy9thizrAifjugTEV6WQvmpm2c+tRg==
X-Received: by 2002:a05:690e:d01:b0:651:9286:57a0 with SMTP id
 956f58d0204a3-66284bc938cmr10940886d50.0.1781552718978; 
 Mon, 15 Jun 2026 12:45:18 -0700 (PDT)
X-Received: by 2002:a05:690e:d01:b0:651:9286:57a0 with SMTP id
 956f58d0204a3-66284bc938cmr10940850d50.0.1781552718494; Mon, 15 Jun 2026
 12:45:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260603032201.993015-1-jsnow@redhat.com>
 <20260603032201.993015-4-jsnow@redhat.com>
 <87pl1rx5br.fsf@pond.sub.org>
In-Reply-To: <87pl1rx5br.fsf@pond.sub.org>
From: John Snow <jsnow@redhat.com>
Date: Mon, 15 Jun 2026 15:45:07 -0400
X-Gm-Features: AVVi8CfYYa6y_Wv6I7VYLEBYe4vU-IY7KhPE8sCkcxXPLrX6wdSfrlP6ESa3Pqs
Message-ID: <CAFn=p-b1xj_+QeZkOLK+zpptm8vPPfNh-HFm6ihRUw4AUWSCTg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] qapi/docs: remove unused QAPIDoc subsection
 members
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Ani Sinha <anisinha@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, Igor Mammedov <imammedo@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 linux-edac@vger.kernel.org, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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

On Mon, Jun 15, 2026 at 10:10=E2=80=AFAM Markus Armbruster <armbru@redhat.c=
om> wrote:
>
> Uh, "qapi/docs:"?  Shouldn't this be "qapi/parser:"?
>

Uh, sure. It's the parser of docs ... forgive me

> John Snow <jsnow@redhat.com> writes:
>
> > All users of the QAPIDoc object should be iterating over all_sections
> > and not grabbing arbitrary subsections, if possible. Remove the 'body'
> > and 'sections' members, as they are no longer used.
> >
> > Signed-off-by: John Snow <jsnow@redhat.com>
> > Reviewed-by: Markus Armbruster <armbru@redhat.com>
> > ---
> >  scripts/qapi/parser.py | 6 ------
> >  1 file changed, 6 deletions(-)
> >
> > diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> > index c3cf33904ef..b33edbba74f 100644
> > --- a/scripts/qapi/parser.py
> > +++ b/scripts/qapi/parser.py
> > @@ -732,8 +732,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Op=
tional[str] =3D None):
> >          self.all_sections: List[QAPIDoc.Section] =3D [
> >              QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
> >          ]
> > -        # the body section
> > -        self.body: Optional[QAPIDoc.Section] =3D self.all_sections[0]
> >          # dicts mapping parameter/feature names to their description
> >          self.args: Dict[str, QAPIDoc.ArgSection] =3D {}
> >          self.features: Dict[str, QAPIDoc.ArgSection] =3D {}
> > @@ -742,8 +740,6 @@ def __init__(self, info: QAPISourceInfo, symbol: Op=
tional[str] =3D None):
> >          self.errors: Optional[QAPIDoc.Section] =3D None
> >          # "Since" section
> >          self.since: Optional[QAPIDoc.Section] =3D None
> > -        # sections other than .body, .args, .features
> > -        self.sections: List[QAPIDoc.Section] =3D []
> >
> >      def end(self) -> None:
> >          for section in self.all_sections:
> > @@ -766,7 +762,6 @@ def ensure_untagged_section(self, info: QAPISourceI=
nfo) -> None:
> >
> >          # start new section
> >          section =3D self.Section(info, kind)
> > -        self.sections.append(section)
> >          self.all_sections.append(section)
> >
> >      def new_tagged_section(
> > @@ -790,7 +785,6 @@ def new_tagged_section(
> >                  raise QAPISemError(
> >                      info, "duplicated '%s' section" % kind)
> >              self.since =3D section
> > -        self.sections.append(section)
> >          self.all_sections.append(section)
> >
> >      def _new_description(
>


