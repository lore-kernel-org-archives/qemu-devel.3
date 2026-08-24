Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86C6BC5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 09:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyRGy-0004cj-CP; Mon, 24 Aug 2026 05:47:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyRGw-0004cb-SU
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:47:18 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wyRGu-0000I1-VS
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 05:47:18 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38511175ad3so3056549a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 02:47:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787564835; cv=none;
 d=google.com; s=arc-20260327;
 b=aj2tiIvfYDzAjCxPht8eVPYm6VYUQE6Wl2wKpRprvUaey3HdWiteKQVcRkQgY33QAU
 BbwcljV+WsB2BJjOW0cwHT4m6ma6+/D83OIOhi9zw7fsQ6BJ+Fdqm4JN3QJbJmx5gYyQ
 1+TEf6/gCnGSZ9n+vOWdxtmjByT+CwcVButgvBvfP8CV1OfsCW5d/c/McBNy2yXIfTFJ
 AhVEwSvx1HsYstwBLHv6bFifp/EDCQWfsk/CqCGXfr+7O99F+r3I8Ajyh0fgEjcZMRhu
 blcmQU+SNs5hM+meXPbX8Jk3YTqPvow9V45c0tD2OwAyeX+0c5Bi9Z8DXjh0l5CGVxVA
 N0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=q9NxUmvstPVn5vav+KNHQtMxLiwv7kF2oGknPXCctx0=;
 fh=n/xPXA2ggus08HOk/bnJE6kraWzcHMgwdt4UJe1O+z0=;
 b=puY8T2K/4JP/5tDVMmlSG+TnERni/p6vWyBVohtibe7R/UjH31Cy3FhzhuAZVpCdYC
 FdvckhKofsG4tpeTCzmfl35kF7FF7ezXQ0GArXzUi6s1Wpf5rRMV/SCvtimOLGfyvxdu
 mL4HvaF9Qf/Pus5tLc4dUdcIxwG38J0uqOS2KFd2g0e3JsaWDNQhQG3JnNFz6JPpysLa
 4fmlCv4CCGpBEogqHgP14xIqmFsR1GTcmqcAUnvByv+4j1b1TNBwavaMEi3FOvitQTx+
 kgiNc04g9se9j4KucLxz/JVHLTMZ9wFzDytlVnT9hiK7D9r9yv3W5ZiQnj87LxmFfxLn
 kOyA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787564835; x=1788169635; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=q9NxUmvstPVn5vav+KNHQtMxLiwv7kF2oGknPXCctx0=;
 b=TXZEZA4DVhErl9Fl+toJYPYSlKKVIlRDyHkvsKRM0Hq4uuMqi29lck2dm65LiWZ7h7
 eCTuyAV8f+qtGOgOzyEoZfep9phvsZpdlDzs6cyeLLdWbltpl7j9uN1RkA4mkwGsivCt
 4VWF47HeHORkgwxDvm7q9oCm+dsEK7w9lBkROumjsVt8l7DGnx75h2tboPmmFUKjsR27
 iyZx3VGcZeQUq5yUjaVrnUiY6MP4BT7iToEmdTzLhGgpJ5bo+eIzVxsh08ZnpY8tWWxI
 7TUWCbZxYQmGjMtAjB+NAOC00OOCveSxbTn+wImj6b7LXX9kuScZ68GJYojW3DYmlfVO
 fikw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787564835; x=1788169635;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=q9NxUmvstPVn5vav+KNHQtMxLiwv7kF2oGknPXCctx0=;
 b=d4VVI+JVLyuKwwjCkCUMJ3vLQ83KgIXgxgY2x/eY4PWtywzn1+Yu2DU8jIIFvYKHFE
 0jnek/ZJ9SViyYzEq5aspXcdrKzI+YnAyCzA82SQnfJevGrn0aygSxCvA9+feODJdNbd
 xx70j2qi8buBPf9Du7eUdrP4OVbD4CdwANy8xYeHd8WJqiF9ThTvjWujKzPfnRroBkzD
 EnlWzUTTPPxWZ8Y/DHwpEpH5pwM7VV1ZdcsrJbA41kVd39bu5g7IBP6INGbf1BR2Py4i
 jo0R0Jiv/MV/iiPnYzufLjn5KF1EeE05S0lrVgyRmUNq3NpnCt4FGFsMZNTXzmycaMDk
 FAVA==
X-Gm-Message-State: AFuF++kTVlIShIIiw5gabmFkQJNR9X8UEMASeN+gYo6CVNBhWwMUq3FD
 xHrpkI3NtqQYwjqtZnE2yomQ2c0B5T5pOMc9lRnYJnWVIs88Tf41zF7kYaWtrHZ4W6Z59JW8u1m
 HXB8AMVSporX2pg6VJjXbpwvKztpxEHc=
X-Gm-Gg: AR+sD12FYUquBcmDHQmNDueh38ZzS7qQ6ufF2jOA3C+ckWDPePYOBj5OnRAkOTl+Bsk
 riwKUTO2K5eIF4ca0DKA/ZlsDk2CFmVgJS51xMWtNHkiM/OjIxplGx7q0vqoHTcxs1sCBdhzuKV
 IrUUHbpXrh8DRF+T0rJuCepztOetxvIkfpORvTjKei27G87OHpXo2OJEq591s6C36ll+1YVnTRf
 8+ovwuK0+j+L15cJKgq4Z9isw9v9Ym+x64njCJdWJvCi2qHbu6JnCeciiTDr1paLiG2ESfRmJIw
 9CJBf5euQLjqqNOaRvMEcqgr85AKipKcEZJWRQu7fJxgp0w9KIg/rYD1f0hFx5RjFaNTDvuv+bz
 /
X-Received: by 2002:a17:90a:da90:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-395c3547daamr49448661a91.7.1787564835211; Mon, 24 Aug 2026
 02:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260822104329.42121-1-christian@quante.one>
In-Reply-To: <20260822104329.42121-1-christian@quante.one>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 24 Aug 2026 13:47:02 +0400
X-Gm-Features: AcwNN1VH46zuSDbq-WPWXLYyshdjKagv8f4yMshn--Ap-ii66docgCL4f3Su3ds
Message-ID: <CAJ+F1CJNFWBzHHxteGW8nzow7yQz0WEJ9Jq9nnb=nnZkY4hf-A@mail.gmail.com>
Subject: Re: [PATCH 0/3] tests/qtest/fdc-test: give each test case its own
 instance
To: Christian Quante <christian@quante.one>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, jsnow@redhat.com, 
 farosas@suse.de, lvivier@redhat.com, pbonzini@redhat.com, kwolf@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Sat, Aug 22, 2026 at 2:45=E2=80=AFPM Christian Quante <christian@quante.=
one> wrote:
>
> The test cases in fdc-test share one QEMU instance and, with it, the
> state of the floppy controller.  Several of them only pass in the order
> they happen to be registered in: read_no_dma_1, _18 and _19 fail when
> run on their own, and fuzz-registers leaves an unacknowledged interrupt
> behind, so it works only where it sits today.
>
> This takes up Kevin Wolf's invitation from the review of d00567f7fb and
> 431f59a34d: "If you feel like addressing the wider ordering problem in
> the tests, too, you're welcome to do so."
>
> Patch 1 registers the test cases from a table and runs each one in a
> QEMU instance of its own.  No test function changes what it tests; the
> three read_no_dma cases insert their own medium instead of inheriting
> one, and test_read_id stops ejecting at the end.
>
> Patch 2 skips the test cases when the pc machine is not part of the
> build, after 4e37f749dd, 6500a6abe6 and bb98963d6d did the same for
> drive_del-test, device-plug-test and pxe-test.  Patch 1 routes every
> test case through a single function, so one check covers all of them.
>
> Patch 3 adds a test case that keeps d00567f7fb ("hw/block/fdc: select
> the drive named by the READ ID command") from being lost again -- with
> one drive, answering for the wrong one cannot be told from answering
> for the right one.  It needs a machine with two drives, which is what
> the table's args field is for.
>
> Measured on this series:
>
>   * every test case passes on its own; on master three of them fail
>   * the suite passes with the registration order reversed; on master it
>     aborts in send_seek()
>   * removing SET_CUR_DRV() from fdctrl_handle_readid() again turns
>     exactly one test case red -- the new one -- and leaves the other
>     sixteen green
>   * each of the three commits builds and passes on its own
>
> The price is wall-clock time: the fifteen test cases in the table now
> start an instance each instead of sharing one, which takes the suite
> from 0.78s to 2.8s.  The qtest timeout is 60s.
>
> The pattern is not new here.  Of the 195 files in tests/qtest, 57
> register their test cases with qtest_add_data_func() and none uses glib
> fixtures; boot-serial-test.c is the closest model, with a table of test
> definitions and a shared runner that starts one instance per entry.  72
> files still include libqtest-single.h, which is why the test functions
> keep reaching their instance through global_qtest instead of carrying a
> QTestState around -- that would have touched every one of them.
>
> Christian Quante (3):
>   tests/qtest/fdc-test: give each test case its own QEMU instance
>   tests/qtest/fdc-test: skip test cases when the 'pc' machine is missing
>   tests/qtest/fdc-test: check that READ ID answers for the drive it
>     names
>

Series lgtm, however it takes ~10s more now.
Tested-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


I guess I should submit my old patch
https://patchew.org/QEMU/20260512065633.3542562-1-marcandre.lureau@redhat.c=
om/

and perhaps add fdc to the slow_qtests dictionary..

