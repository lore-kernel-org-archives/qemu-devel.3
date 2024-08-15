Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42EFC3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:30:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sebTR-00028H-LX; Thu, 15 Aug 2024 10:29:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sebTP-00022g-0U
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:29:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sebTM-0005PL-Pa
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:29:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723732142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pLW8VxYvBfkl9d6XaUqzmKjRXnbivJG5S8ggECncIC4=;
 b=BGr3OMWSTcEA7XAA2puEaxStp1VFD2D3eWq4AVF+TTHAmarO0bzhKabNMAR1G+9+EjqJgd
 yTRxjnGJwOFtAM+JS5FV7yjzEJ/neRDkoZOaXO0p3upzWTxq2Loo26XGMO6v+ULIhdfom+
 3He76o26PDgY4LkUMHN99IeCS+PKetI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-V5t_3iL1MLuQsMuT0XUv9A-1; Thu, 15 Aug 2024 10:29:00 -0400
X-MC-Unique: V5t_3iL1MLuQsMuT0XUv9A-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-5bec23ba156so310325a12.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:29:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723732139; x=1724336939;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLW8VxYvBfkl9d6XaUqzmKjRXnbivJG5S8ggECncIC4=;
 b=VZIeYIsJ6AaXlNEosBCcE2VAaOuvsSdHEbqDTseTcouzmkwCimRU1BWnjCvAOuOr1o
 rCFPqakYGh8Oa0rmvoudOKuFrj8yQndlPuNDh/bk7GC0v/O9Fss6VPXw9EdiiSrSLNWX
 r9nhk1Xy24Bc63kTY48AFJJrBPUGHkpD1WiSNeNdOiD6DKVVDdG3Rklts9qgqnGTTQUG
 AnkZ3EGVyjHpVkJi/0OOcsnRsgpr39ufzoqleuGvg3HVRMb4BrnkaGdb2ZqJgJstYaKV
 6G/sxoxu25FT3AN4A2VZ++BgvvYgpXdemAieSA8FFYvQNYom5PjI0+OiZNus6gU3ozj6
 6T1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgG6VfYvzkh9QaBTwlsmrAsnb+KenPVBkYZ/C737YNyw+whULOqyYwVPzX6et3V9K99EKGaWydxdA272qGZM9Eb36fUZw=
X-Gm-Message-State: AOJu0Yxze2mSVvQgKuFWK6JzLGcaQZvw7hoKdFBGHbjzxGotOxJed0c3
 NZUWTUt2TgrkLg55nIJWgjopBtwlKhoCU6Q04SBnIp2Tce+b6aIj5Eg8+EMP7nHGsjpRMnnuXj0
 +O/ZzFwbCUwGXRaJKCXNSL4AkL6VTqCCz3SQILdrV1GCcIxiKjMso
X-Received: by 2002:a05:6402:e83:b0:5be:b6ae:dc68 with SMTP id
 4fb4d7f45d1cf-5beb6aee07amr1903250a12.10.1723732139486; 
 Thu, 15 Aug 2024 07:28:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxUvAIrtGJlhS2+cKFnc3kpN1cB4UpecvdGY8jlQAP3RH/LlQE/BcOYPhfJrk3tkUlBALFgg==
X-Received: by 2002:a05:6402:e83:b0:5be:b6ae:dc68 with SMTP id
 4fb4d7f45d1cf-5beb6aee07amr1903190a12.10.1723732138674; 
 Thu, 15 Aug 2024 07:28:58 -0700 (PDT)
Received: from redhat.com ([2a02:14f:178:8f0f:2cfe:cb96:98c4:3fd0])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bebc081a24sm938598a12.95.2024.08.15.07.28.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 07:28:58 -0700 (PDT)
Date: Thu, 15 Aug 2024 10:28:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Michael Roth <michael.roth@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Weiwei Li <liwei1518@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Eric Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>,
 qemu-arm@nongnu.org, Peter Xu <peterx@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-s390x@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 John Snow <jsnow@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, qemu-riscv@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>
Subject: Re: [PATCH v2 16/21] virtio-net: Use replay_schedule_bh_event for
 bhs that affect machine state
Message-ID: <20240815102754-mutt-send-email-mst@kernel.org>
References: <20240813202329.1237572-1-alex.bennee@linaro.org>
 <20240813202329.1237572-17-alex.bennee@linaro.org>
 <20240813164631-mutt-send-email-mst@kernel.org>
 <D3FEPPLH78YW.3BYA9B4HYGN1U@gmail.com>
 <20240814030308-mutt-send-email-mst@kernel.org>
 <87y14z81ak.fsf@draig.linaro.org>
 <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D3GARIYVC16C.20SXVKSIMLED4@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Aug 15, 2024 at 05:12:32PM +1000, Nicholas Piggin wrote:
> Could be a good idea. Although I'm not sure what to do with
> all types, maybe we can restrict what is supported.
> 
> > Is this wider re-factoring something that can wait for the next
> > developer cycle?
> 
> I would say so. It's not quite trivial to do nicely since
> things are a bit tangled between util/async and replay.
> 
> > >> I had started on a conversion once but not completed it.
> > >> I could resurrect if there is agreement on the API?
> >
> > I would certainly welcome it being cleaned up. The supported replay
> > devices are very piecemeal at the moment.
> 
> I'll tidy up and post an RFC for how the new API might look.
> 
> Thanks,
> Nick

Fundamentally it's virtio net, up to Jason. I don't like messy
APIs and people tend to get distracted and not fix them up
if one does not make this a blocker.

-- 
MST


