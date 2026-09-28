Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3732DCA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBAJi-0008Uo-RA; Mon, 28 Sep 2026 08:18:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBAJM-0008RX-IB
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBAJ9-0007Oz-3E
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 08:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790597890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/vrLJXlrs9bLYKtYtporGPrELgOtVfcRvQQzCv5liU=;
 b=X03R0EYZPTo/yFXWmv4soLWsGI3FEUHjsZYWR6WHm6DWxrmO9Lm6VFuPuhabxqfEpF0Fsq
 qkSu7acli1mfepOP5vwCcdHqxusXq3vKNYC0R6dTLzrIvzFgnz+HSLHF/OphosvW3w9m3Q
 5fPUPsBl9SbyloD/HduNCWpXAvuIe1A=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-312-XybCGkfKMwW9YHVF8Lnt6Q-1; Mon,
 28 Sep 2026 08:18:03 -0400
X-MC-Unique: XybCGkfKMwW9YHVF8Lnt6Q-1
X-Mimecast-MFC-AGG-ID: XybCGkfKMwW9YHVF8Lnt6Q_1790597881
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2BC361955D4D; Mon, 28 Sep 2026 12:18:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92796180036E; Mon, 28 Sep 2026 12:18:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27E7421E6A04; Mon, 28 Sep 2026 14:17:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org,  Richard Henderson
 <richard.henderson@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,  Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>,  Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Alistair Francis <alistair@alistair23.me>,  Peter
 Maydell <peter.maydell@linaro.org>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  qemu-arm@nongnu.org,  kvm@vger.kernel.org
Subject: Re: [PATCH v4 41/55] target-info: add SysEmuTarget none
In-Reply-To: <CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
 (Yonggang Luo's message of "Mon, 28 Sep 2026 20:04:59 +0800")
References: <20260926070057.1234-1-luoyonggang@gmail.com>
 <20260926070057.1234-42-luoyonggang@gmail.com>
 <87zex1fvh4.fsf@pond.sub.org>
 <CAE2XoE_QozVhBix251nyUQkFMi6p_4idGXpVOT0LSP7VYK8ddw@mail.gmail.com>
Date: Mon, 28 Sep 2026 14:17:58 +0200
Message-ID: <87ik3pfu2x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Yonggang Luo <luoyonggang@gmail.com> writes:

> On Mon, Sep 28, 2026 at 7:48=E2=80=AFPM Markus Armbruster <armbru@redhat.=
com> wrote:
>>
>> Yonggang Luo <luoyonggang@gmail.com> writes:
>>
>> > Add a none target for when no TargetInfo is selected. It is last
>> > so existing SYS_EMU_TARGET_* values stay put, and it is not a
>> > qemu-system- executable name. target_is_none() and target_none()
>> > report that state.
>>
>> Why does it matter that existing SYS_EMU_TARGET_* stay put?
>
> We need a state that not a real CPU target is selected( I called it none),
> then we can use it to list all targets. for example, do query-targets.
> query-machines(all machines for all targets).
> Any better ways to handle it would be appreciated, I am not choosing to s=
et
> it to NULL because
> that would cause too much NULL-check error, as the pre-existing code
> presume there is always a
> CPU target present.

Doesn't answer my question, so let me try again :)

In your commit message, you explain "it is last so existing
SYS_EMU_TARGET_* values stay put".  They do, but why is that useful?


