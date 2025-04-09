Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CB22C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 17:17:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2Z2H-0006VN-OC; Wed, 09 Apr 2025 13:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuanchu@google.com>)
 id 1u2YfI-0002Xc-BL
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 12:52:43 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuanchu@google.com>)
 id 1u2YfE-0001fd-55
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 12:52:39 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2240aad70f2so8105ad.0
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 09:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1744217551; x=1744822351; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KxhzB/rvLn01hoZmiKiKmNuUTf5Uqkd1lPGcDdEtm80=;
 b=XOUUPibw/pUOpAtoOUtUZXiyl8ZzSC+hPQxU8PH7ZrLE+8rMO6wSCN517pZrME5OE+
 QpK3r0N6e6RQgDSH+7tP8p5wMOTflUhXxr32/nQ443oXvQlE1jup5w4LL/BFIG/WKe8k
 7SS/QQRstVCLm8VnAtqhnPiBPa9gGAezjFI6UHE409HUaGQaD7XL/A0X71+D0zP4b3dP
 wg27ku+H/rfvWPW+czkmk85DfDzaL9tmBKqUiVr72DQbixuV3sFVFNUgfNK80ov1UDbC
 1/9W3yCw+fBkrJLGBnxRvpg7R63DinftrdTFWIu55XggHBpTTDc1FS0QLolC/Iqz1Q/R
 lnXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744217551; x=1744822351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KxhzB/rvLn01hoZmiKiKmNuUTf5Uqkd1lPGcDdEtm80=;
 b=E3bxpz50A2SUV5I8r7PM5mPypac1vkJ9EMwCibLyXBn15CThNPbyjQXHPLg9XeGarh
 /PgyGhyTqslw+I2aUXy4Tqx7zRw1DspBijikmGvx2y32U9cfrbD33dc2q9vpWDm1f3Kh
 3ptrXMq0E/jHWr9PvTIScl5SMnmOSpCqsya5VDFwidTCG4+l+ALdcOIBnClstLrdB189
 Oq5Az9+aQyOlh1YmyJq5/MSEbUkJ4ksvLeN264gdCRv0dDXOQbuhq8hffGxFLNYZ/M0S
 UFZrpi74S8tQe+XU4vsWav+YO7ZM4TrS1BIAYwemEaIT1Mak+JW/lf81HQRWh/pUM61v
 P4tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjc3MDffEhW4RPHlay2mTrgYQELUAg4G2KIg3fjCI9k4/vsdH6Vp1TJH7RMJiVJQ+N3ZcHnvfah7n1@nongnu.org
X-Gm-Message-State: AOJu0YwVQqOjsElrjMPku5i2RW/XbnY7bgtPLa45IvSTRWF1wWeg+g3f
 AZy7uQcHZkjH8K+YnUFfTQAfAJYPOsQfZ3ngNBclQCRj3tongFORk9vcQgx3biZHWx8DAx6fc94
 BBYeNsSys68HcYq4CpsT85uY10Ci08VZP6wus
X-Gm-Gg: ASbGncvdTbchaawfLMcym7yd+dlOP1Cl8ononXhvcrTGPpuj11E5QzS03CJryXCq83a
 VZuYk713QfzGBlaMYv5zQOugMNrTA3Lkc5wfDHNS3PCauLUNkWjNNQAe4u75mmIymAvlsg25Qh6
 sQ1ZwR66nGYn//FwvN0qM6O1TT6qs8dgDQh66V5ffuYdkUiSKWLKw=
X-Google-Smtp-Source: AGHT+IFZlX+H2sLxd+0i1q4/NMVWp3DoVwGucarYZ0dIheff4noN52DsOyZlpg5W3rt1uBZ3mZQdHc0M5PnL3rAwwO4=
X-Received: by 2002:a17:902:db06:b0:21f:3e29:9cd1 with SMTP id
 d9443c01a7336-22ac43c9b30mr3186535ad.1.1744217550776; Wed, 09 Apr 2025
 09:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
 <20250407053811-mutt-send-email-mst@kernel.org>
In-Reply-To: <20250407053811-mutt-send-email-mst@kernel.org>
From: Yuanchu Xie <yuanchu@google.com>
Date: Wed, 9 Apr 2025 09:52:12 -0700
X-Gm-Features: ATxdqUEMTbMWjK5jZUT-GXTtxRsyn6Pfsae1bAmml38SIv5bGn_NfBEFtcO4Zp4
Message-ID: <CAJj2-QE1fO5GhYL_N2=w+xqd+yspkqjrn4HGeTrPUWZYbTp+Sg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/5] virtio-balloon: Working Set Reporting
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org, 
 David Hildenbrand <david@redhat.com>, Yu Zhao <yuzhao@google.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=yuanchu@google.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -175
X-Spam_score: -17.6
X-Spam_bar: -----------------
X-Spam_report: (-17.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 ENV_AND_HDR_SPF_MATCH=-0.5, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, USER_IN_DEF_DKIM_WL=-7.5,
 USER_IN_DEF_SPF_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Apr 2025 13:16:23 -0400
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

On Mon, Apr 7, 2025 at 2:39=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, May 25, 2023 at 10:20:11PM +0000, T.J. Alumbaugh wrote:
> > This is the device implementation for the proposed expanded balloon fea=
ture
> > described here:
> >
> > https://lore.kernel.org/linux-mm/20230509185419.1088297-1-yuanchu@googl=
e.com/
> >
> > This series has a fixed number of "bins" for the working set report, bu=
t this is
> > not a constraint of the system. The bin number is fixed at device reali=
zation
> > time (in other implementations it is specified as a command line argume=
nt). Once
> > that number is fixed, this determines the correct number of bin interva=
ls to
> > pass to the QMP/HMP function 'working_set_config'. Any feedback on how =
to
> > properly construct that function for this use case (passing a variable =
length
> > list?) would be appreciated.
>
> It's been a while. Is there interest is reviving this? I also note that
> reserving a feature bit is very much recommended to avoid a complete
> mess.
Thanks for the reminder Michael! I've been informed [1] that this
should be brought up in VIRTIO TC, but I haven't gotten around to this
yet. Should I send a patch to this mailing list or a proposal to
virtio-comment@lists.oasis-open.org to reserve a feature bit?

[1] https://lore.kernel.org/linux-mm/20241127025728.3689245-10-yuanchu@goog=
le.com/

