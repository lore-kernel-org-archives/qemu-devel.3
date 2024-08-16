Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5B43C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 12:59:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sewXz-00019y-LC; Fri, 16 Aug 2024 08:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewXn-0000wt-05
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:59:04 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sewXf-0004HP-4t
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 08:58:57 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3718c176ed7so664529f8f.2
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2024 05:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723813131; x=1724417931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HdkEt5KhcqJAhdoywwE/9Y0vywYrNHR07p7OQF8KZ1k=;
 b=UyWJ6ck1ymbre0CR0j3WgyRqYeY9a/mvv+V++PRK9mH8fHF8E8QBIcq16UrJZnoUYw
 H0ALy10pPVzIpE2UyzuwNNSp4w+S3ZwPdRp+1wz3RIMqUGwfTQl0Mcf5xXn4IYlD8WBz
 YHa4cAACdISjgcSaeva0vo5VJzi4NrITBzJrxitmXU5vKB78/l61tdoHKAgtc4WMezl9
 N2cfHjQaGmWQX7W62kvRJyZ1U64wVYPQ+23rXwKnPQOoBEv/mJ5dF4SLsU2smxzSycAb
 mGYs7RPEnY1bJbNKmKeRoGdsYVRin+8yluyAd3uxlQXWDw2ogDJloo+VnebnXUq9idj6
 TMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723813131; x=1724417931;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HdkEt5KhcqJAhdoywwE/9Y0vywYrNHR07p7OQF8KZ1k=;
 b=pwYYMTlXM3rAPEITCqAWLCE1+vGex7LBghOIu2O1zFTULMYRsWshKl6jMLX4B33kMM
 ZLpiM0E0Wl4s3plA3UTgs8bqpu7gQS2xQDVslkZ9wrMzteueHaNyIrU9smcan2x1wIOS
 1pWYmOT+2ZawALWy9W30TK9bAqdCBPviJGd8zKLHROG8HSoRQuSwJp9T2c8mK3k235ib
 TC9r4wl2o4JdbL+uMAvzNqAuUfbNBEZ8SqCWWZrjkhNT6Bv1YjObVYM4eg2cWK2AkEfv
 J1lYtSam3l7U+5tEE5/sC/5MIDQHmsNPd0DY5HhJ+pG8q+tFWyr0vgx6JkX6YGp79h38
 kcqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtBiXqoeQjN6mloBtl1RkYPvMjURt8wfS4FYwQEsbR6UBvDXXx7p8nSghLkiBsx5nsFHSIOceGCmMf2f1hQbJs/+KzQf4=
X-Gm-Message-State: AOJu0YwOh5HVTrxFQBBA+iY5eksOyqBp8yLEU+Wx7nRq7Bg6YbrQJd+j
 DbBh+uNOJNzIsMMWQl3spgpMtE+4EMBqRA0EtaMm1p5GG4O9bp1L6PqOKsg+0j8=
X-Google-Smtp-Source: AGHT+IFr+XggQYNedKk0JyyU6hL2lLUl54qD7nk+4Z5Gpyax4tg8bAFUgbHj/GMkAC0T/ueLXjhjNA==
X-Received: by 2002:adf:ed01:0:b0:368:68d3:32b3 with SMTP id
 ffacd0b85a97d-37194649a85mr1981369f8f.26.1723813130363; 
 Fri, 16 Aug 2024 05:58:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3718983a0eesm3645536f8f.1.2024.08.16.05.58.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Aug 2024 05:58:49 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CBF135F867;
 Fri, 16 Aug 2024 13:58:48 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,  Nicholas Piggin
 <npiggin@gmail.com>,  qemu-devel@nongnu.org,  Alistair Francis
 <alistair.francis@wdc.com>,  Michael Roth <michael.roth@amd.com>,  Palmer
 Dabbelt <palmer@dabbelt.com>,  Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,  Yoshinori Sato
 <ysato@users.sourceforge.jp>,  Weiwei Li <liwei1518@gmail.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,  Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,  Eric Auger
 <eric.auger@redhat.com>,  Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org,  Peter Xu <peterx@redhat.com>,  Jiri Pirko
 <jiri@resnulli.us>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  qemu-s390x@nongnu.org,  Peter Maydell
 <peter.maydell@linaro.org>,  Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>,  John Snow <jsnow@redhat.com>,  Alexandre
 Iooss <erdnaxe@crans.org>,  Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,  Cleber Rosa
 <crosa@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 qemu-riscv@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Richard Henderson <richard.henderson@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
In-Reply-To: <CACGkMEtS6kges+_hOum2QnpTWotT_ohkJv8PaFHsycjR10QY5w@mail.gmail.com>
 (Jason Wang's message of "Fri, 16 Aug 2024 10:31:41 +0800")
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
 <87y14z81ak.fsf@draig.linaro.org>
 <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
 <20240815102754-mutt-send-email-mst@kernel.org>
 <CACGkMEtS6kges+_hOum2QnpTWotT_ohkJv8PaFHsycjR10QY5w@mail.gmail.com>
Date: Fri, 16 Aug 2024 13:58:48 +0100
Message-ID: <874j7k39pz.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Jason Wang <jasowang@redhat.com> writes:

> On Thu, Aug 15, 2024 at 10:29=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
>>
>> On Thu, Aug 15, 2024 at 05:12:32PM +1000, Nicholas Piggin wrote:
>> > Could be a good idea. Although I'm not sure what to do with
>> > all types, maybe we can restrict what is supported.
>> >
>> > > Is this wider re-factoring something that can wait for the next
>> > > developer cycle?
>> >
>> > I would say so. It's not quite trivial to do nicely since
>> > things are a bit tangled between util/async and replay.
>> >
>> > > >> I had started on a conversion once but not completed it.
>> > > >> I could resurrect if there is agreement on the API?
>> > >
>> > > I would certainly welcome it being cleaned up. The supported replay
>> > > devices are very piecemeal at the moment.
>> >
>> > I'll tidy up and post an RFC for how the new API might look.
>> >
>> > Thanks,
>> > Nick
>>
>> Fundamentally it's virtio net, up to Jason.
>
> It seems it has been in the pull request from Alex Benn=C3=A9e.

Sorry I'd suibmitted the PR before I saw mst's update.

>
>> I don't like messy
>> APIs and people tend to get distracted and not fix them up
>> if one does not make this a blocker.
>
> +1

do you want me to drop the series for 9.1 and leave it in its current
(broken) state? Nick has already posted a suggestion for the API update
but it seems a bit late in the cycle to include it in the release.

>
>>
>> --
>> MST
>
> Thanks
>
>>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

