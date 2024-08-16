Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C9D7C52D7C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 02:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seml3-0004xg-Fe; Thu, 15 Aug 2024 22:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1seml1-0004vx-VA
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1seml0-0005yq-CB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 22:32:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723775520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=grOFC+auwbhT88GAd3WGdq0vMd4igSM6zH1Gih7uRac=;
 b=Zs4fJMQNuzPfPDhkjbN9AlCvzDAPS0+Ty4E+CfER9DxZbCLUUI3f6BejPXrNAfIUQBeXZQ
 aSJQ3HMueD27jTsg0DHrbwdwnDzIfhAEwvmoQ/ncpJiapx0vfUWDM2spuuBcYDzNh7TPAm
 YqtrUl0ZbUx0ap0UI1vPG1znxGhJDVI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-172-vTfhy8_qNGmvX76fUehOxw-1; Thu, 15 Aug 2024 22:31:58 -0400
X-MC-Unique: vTfhy8_qNGmvX76fUehOxw-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-70eb4de4eb9so1307853b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 19:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723775518; x=1724380318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=grOFC+auwbhT88GAd3WGdq0vMd4igSM6zH1Gih7uRac=;
 b=MCbhfpKGXF/vM2+zwyon4GOuVNCvG/pNOTapDFta3EC3Gsj5se6SBWVflqP96fvwCQ
 FlLD62p9FemJD8pxZmR2XbGdrLoBKyJ1meiUPzkGNd5qKOVRhWo/m07GVqe5QkmF4/mR
 Wv6hmX5ewpWRzG6z+I/h9Prdw1gG8sWzw5aBrf0IgP9n42Hxrs8cbJWBcRr53UeDSmE7
 WPqNTfzLQmexFC+FBVZxM5iwbu089WO17N3Aehb2FqQc6l8hpO1guI5r/j3ztTOpJHcx
 p3U2NvjnepWQu7gRl3KX9JEhA0u7rJyjQCiwAOk+P4XkkAvezx5N4HAQRaRhQr6rHPLf
 d+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5ji4mKLg2BRLSgQA7oRemiWtkfwdhfxhLi4hlAIS1OrSEBvic7fud8stzdmR1Jz4SAwdrPpfXuTlqge7N39GeDLVeMG8=
X-Gm-Message-State: AOJu0Yw8ybpTa+SuU8uLSJ5mIPV0dznk6Dkys/PSbAbZS+aehTbDtHqF
 V/grY8VzbCkxF8g981rkApLu9w8Z3K8X7hi4AOLIrENrvHABaK6fjTMWYxI61WB7Yt1oGh3DJuv
 YeLc/ZyUlTD5mmeuYwT/7a7OkyAOH/O1yrAFCmdg77FtHWfdb0ylT2i2LLoNg+RI/lx+Gt9na3Y
 GlaXHKhTK/diPJ8pelFzljC+ScgWY=
X-Received: by 2002:a05:6a20:d502:b0:1c4:919f:3677 with SMTP id
 adf61e73a8af0-1c90501f4a4mr1993075637.42.1723775517679; 
 Thu, 15 Aug 2024 19:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJuWwjjqx3oWnuAuWBvb8YFwXGmPYPuMHkmgWZqQ76n5ls9Tl6MHiymgcfpxlfg65GqZFgffAzp59iUwWh6RY=
X-Received: by 2002:a05:6a20:d502:b0:1c4:919f:3677 with SMTP id
 adf61e73a8af0-1c90501f4a4mr1993001637.42.1723775516991; Thu, 15 Aug 2024
 19:31:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
 <87y14z81ak.fsf@draig.linaro.org> <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
 <20240815102754-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240815102754-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 16 Aug 2024 10:31:41 +0800
Message-ID: <CACGkMEtS6kges+_hOum2QnpTWotT_ohkJv8PaFHsycjR10QY5w@mail.gmail.com>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for bhs
 that affect machine state
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, Weiwei Li <liwei1518@gmail.com>, 
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Eric Auger <eric.auger@redhat.com>, 
 Song Gao <gaosong@loongson.cn>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, 
 qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, 
 Alexandre Iooss <erdnaxe@crans.org>, Konstantin Kostiuk <kkostiuk@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 15, 2024 at 10:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Aug 15, 2024 at 05:12:32PM +1000, Nicholas Piggin wrote:
> > Could be a good idea. Although I'm not sure what to do with
> > all types, maybe we can restrict what is supported.
> >
> > > Is this wider re-factoring something that can wait for the next
> > > developer cycle?
> >
> > I would say so. It's not quite trivial to do nicely since
> > things are a bit tangled between util/async and replay.
> >
> > > >> I had started on a conversion once but not completed it.
> > > >> I could resurrect if there is agreement on the API?
> > >
> > > I would certainly welcome it being cleaned up. The supported replay
> > > devices are very piecemeal at the moment.
> >
> > I'll tidy up and post an RFC for how the new API might look.
> >
> > Thanks,
> > Nick
>
> Fundamentally it's virtio net, up to Jason.

It seems it has been in the pull request from Alex Benn=C3=A9e.

> I don't like messy
> APIs and people tend to get distracted and not fix them up
> if one does not make this a blocker.

+1

>
> --
> MST

Thanks

>


