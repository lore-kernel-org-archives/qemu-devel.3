Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726C9F01832
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyVgo-0002S7-Fv; Fri, 06 Mar 2026 08:58:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVgm-0002Rd-83
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:58:00 -0500
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyVgk-00007a-8A
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:58:00 -0500
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-64c9a6d6b70so7976803d50.3
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 05:57:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772805477; cv=none;
 d=google.com; s=arc-20240605;
 b=J3vNVv0mARp7SmL/iIBTkypO169WIN19QVxtJizss7YuEz5JNGVADdjbo9q3DXCpLn
 0+53cTV1RQX0D3mqhWdGLDgdoRpykpWOd/44GLXA23nQ1jzXPrCQFet1vbTwWgH5wpCs
 eqJLv3Jsfcfi7u95cYSssPD4Ess6JbNm5jjD3LqP/1A41i/B3aM8L05mdEgqKYyc2meS
 PZ+wgxSVNchhll6qt1HEMLO2xHX4ZhCFgObWRKDXHK0tq2/rgdpLhg+e4RiqatZtF4ou
 +2a3TIFdngiEAcZq0rydO0dWSXMvjuGGW2FB65US2gCE65zUuMqlU6FvfdvfGeUoLahj
 WmXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=X1/i6bE23+aW64OrkVkMQTJduEnzrPzmL7Flh/7rttw=;
 fh=WuGTcfZk+/DSaJPWowGaVUi61RJ4vPPARkDl4zYlI6Q=;
 b=GAxIkuwCmXCZj+EbrHn398wRwYvt7STdEFgxg2mUygEv6C8htxyWMgccDd8yQp6HC6
 gbGTj/OvWG269iR/OQA1gpyIUtGFRIYsPJPKipiF1yScv+wEfs4e5BZpZI7EY8voAVIr
 UdLpj6MC8te8CSAfDzMEX+mislJ5+fWNLZ2iSS9ZK4uqKNJd/C7XUEMeiN1iH3F2iM7F
 qoN46S4IRfvIoFwPJWC2Nl/wknqpVyHO+bRfTvIHnmQYATQSbwK5hI1r9Z3cX+rrYWEd
 DfiizSqMo+h6EkxrO5Qvo1BvcS0ilBrfeTaG6DEQzQaAjn2UfHj+7jd11FJ+T7CqMlEl
 O49g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772805477; x=1773410277; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1/i6bE23+aW64OrkVkMQTJduEnzrPzmL7Flh/7rttw=;
 b=Oqt/vgrk6QOAbKAjMKcyvrPfkTbfv0nzMN8VtawT4n8hQ8PZfBjoGOjW4wAni9Q75E
 1C7soIZoblDrVqW85/B4KT+wBANCMBfjCndk8lcnWgArIwKAFwEbLbGF1ATxJthAWj9K
 tQdv49h2y3/CY2rnARid9/8aOSefmDkfT5w8Iov+UGBMWVCuNpAeLxveJqeAmbEzP6+O
 P/PevZ7xKYGBcxNUhYu8tp2JdCjtBOcW9sgac5YVubk5k9G6vn9ifFtegiym0JcsZJs6
 muCIFkNphr1E5M7b/RdXU55fSVA4Ha8euVHsjU9l0utGRndUSl/P3GCv5UMe+TpvJYoN
 BkhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772805477; x=1773410277;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1/i6bE23+aW64OrkVkMQTJduEnzrPzmL7Flh/7rttw=;
 b=ECt5gJP4EeE2QlpZE5r1TUiKOHcrORwIl3y6LwIZLbcgaDRN4mIOdwnCe2H11w3vCq
 t9syqkfErpENK5VF4j68fTlpMYzeUEwbmRc7tbxGhVAGV4tYs5DeRGf6gYXv43OQssVf
 Nu/wsb1uAdCJJGCabDpZ8xdVKKHPyR+XvWN5Waprh+YwJvqeEOYDVvf2x7l7cwZjZSno
 AwP2RwLsNbGvGYVpnUvHqQYOQ6zYwZDrLpfMIbrorhbKsVfqnankBsFwGxz2LX6qAFoU
 ue6UXoJ2v8KniYvXzCfNhQNI4QeloKfX1ny0o71U3X6PWzrBuJ2eYQfFhXRb0yFCeiBo
 qapA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXf0QqnfbPxU9YW3OrA1/pvccdv9bwkP2MSJcXyom5/ibLa2agmUvK4GKALwIVrQWpS4heFjF9OOM/5@nongnu.org
X-Gm-Message-State: AOJu0YwFMWVOZvzl+7NLMB/UatgdR8CjBLsu/lojH/MEBorzQhZABml5
 b09KWIoIJEg2F/OIPzMV3F32CaUq4BXYBGkyWcP9NBtJ+Cm87FrPMBzeC3q3+sbFBq9wCbIcv2M
 i41U03iUcstz9a9hq+iITIMFpAcOUg2pKqOPiNvG5366PECqk5XFvgfI=
X-Gm-Gg: ATEYQzysvuVQB+huL7cy3ZHd1uhprpHsAMBOORZUI/asZfVebyfdOdhp//QMONQMA1h
 73e37AElA5BjFKi+5pFnTkttdVHjCE4uQhTuz/IsP2sNuAtiGDdhuWDcwA/oRMvIAMmnzFOM3su
 MCO1N80RkqL+ubC/cxCNBtnEPdiNG8/2HEPmYVMLKTcTnX4lnRa1wWjBFSMyPGIfgZJoEXeCkSB
 m87QJKWDCi1URyslN/PBTMGA/VPs2zd/ln8cfZq4+XXDwjbMs6TEK9Chv72SmiQEjsKwGk/treE
 1zjU8zEPHF4Wo6Isa1/r0Aifkc1mIpyvLu8UiR/4Lsz7NCkUl2c8n7cKMmH0YyjAQQlWc0S/Ro9
 MPA==
X-Received: by 2002:a05:690e:4184:b0:64c:2581:eedc with SMTP id
 956f58d0204a3-64d142c513emr2090894d50.48.1772805476864; Fri, 06 Mar 2026
 05:57:56 -0800 (PST)
MIME-Version: 1.0
References: <20250515222014.4161-1-farosas@suse.de>
 <20250515222014.4161-5-farosas@suse.de>
 <aCsPOyZCu-AcZOI3@redhat.com>
 <CAFEAcA_BvkKaF-qgJm25wSwuLEBedxL_pRVedQadCh1fVQBr8w@mail.gmail.com>
 <aagKqykyAO1svo_f@redhat.com>
In-Reply-To: <aagKqykyAO1svo_f@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Mar 2026 13:57:45 +0000
X-Gm-Features: AaiRm51HhIiEiKxA-liK-L3yoCrBSYJk3FORGw3JcwzOHuJCErPbP3lvM8Pog8U
Message-ID: <CAFEAcA88RR05VXhz=j_+EiDYHUUtsMW0kX9PV04B1toK_dd95Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] chardev: Introduce a lock for hup_source
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 4 Mar 2026 at 10:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com> =
wrote:
> On Sat, Feb 28, 2026 at 03:16:11PM +0000, Peter Maydell wrote:
> > I had a look at this, and although I couldn't get a specific
> > backtrace, I got enough information from asan leak backtraces
> > and looking at the code that I think I understand where the race
> > is here:
> >
> > vhost-user-test.c:test_server_create_chr() sets up a chardev with:
> >  qemu_chr_new()
> >  qemu_chr_fe_init()
> >  qemu_chr_fe_set_handlers()
> >
> > For the "connect-fail" and "flags-mismatch" tests, it includes in
> > the options to the chardev "reconnect-ms=3D1000".
> >
> > qemu_chr_new() ends up in tcp_chr_open(), which calls
> > qmp_chardev_open_socket_client().
> >
> > If reconnect_ms is not 0, qmp_chardev_open_socket_client() calls
> > tcp_chr_connect_client_async() instead of doing the connect synchronous=
ly.
> > That kicks off a qio_task_new() to do the connecting, and immediately
> > returns, so we return successfully from qemu_chr_new(). So
> > test_server_create_chr() will continue execution into qemu_chr_fe_init(=
)
> > and qemu_chr_fe_set_handlers().
> >
> > qemu_chr_fe_set_handlers() calls qemu_chr_be_update_read_handlers(), wh=
ich
> > calls the chr_update_read_handler method for the ChardevClass, which he=
re
> > is tcp_chr_update_read_handler(). That function calls update_ioc_handle=
rs().
> >
> > Meanwhile, the thread that got kicked off to do the connect is
> > running in parallel. If the connect succeeds then qemu_chr_socket_conne=
ted()
> > will call tcp_chr_connect(), which will also call
> > update_ioc_handlers(). (If the connect fails then presumably we end
> > up in the tcp_char_disconnect or otherwise destroying the chardev,
> > though I haven't figured out exactly what happens in this case.)
> >
> > None of this appears to be taking any kind of lock while it modifies
> > the SocketChardev fields, so we could have two threads in
> > update_ioc_handlers() simultaneously.
>
> It is subtle, as the QIOTask object deals with 2 separate callbacks.
>
> The callback that is provided to qio_task_new() is what is invoked when
> the task is marked as completed. This is guaranteed to always be
> invoked in main event loop context.
>
> The callback that is provided to qio_task_run_in_thread() is what runs
> in the throwaway background thread.  When this callback returns, the
> QIOTask creates a glib idle source in the main event loop to run the
> completion callback.
>
>
> So wrt char-socket.c, tcp_chr_connect_client_task will run in the
> background thread, but it only calls QIOChannel APIs so is safe.
>
> The qemu_chr_socket_connected method will run in main event loop
> context, so it does not need locking wrt other chardev I/O
> callbacks.

This is starting to sound like the problem is the test code. The
test code is calling qemu_chr_new() and qemu_chr_fe_set_handlers()
from a random thread it created by directly calling g_thread_new().
So these calls from this thread do not have any kind of lock and
can run in parallel with the qemu_chr_socket_connected method from
the main event loop.

I guess we need to take a lock here, but which one?

> >  How is this intended to work ? Is the test case code incorrect to assu=
me
> > it can work with the chardev it got back from qemu_chr_new(), or should
> > the chardev be handling this case?
>
> The test is really rather had to understand, but I feel like something
> in the test ought to be looking at the CHR_EVENT_OPENED event to
> identify when the connection is actually established ?

The way to get a CHR_EVENT_OPENED would be to set the frontend
handlers with qemu_chr_fe_set_handlers(). It's the call to set
the frontend handlers that is already going wrong. (But the test
doesn't really need to care about the EVENT_OPENED: it can
just wait til it gets the "you have some data to read" callback.)

thanks
-- PMM

