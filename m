Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E4FC53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolqe-0002YA-2D; Tue, 28 Jul 2026 13:44:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wolqc-0002Xa-WE
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:44:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wolqb-0006ve-57
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:44:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c15e03c2763so18148966b.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 10:44:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785260648; cv=none;
 d=google.com; s=arc-20260327;
 b=KV92QEC/S/6eAlStVPqOi5wwnfvaUMdlknwffDcAtYKuaGmeMGEFvUpvp8rmb8TfeC
 2BUC9CXYEKQAW5IEEXjDuEmZ17cv6rGXDrzxCJrPcMkCaUr7vQuA9yJYzg1TSRWQzvm2
 kdDPjvzHraNEuFaD+hwp6mJauIlcdfryt6ml5GvnxIMVSxFGXii/n0d2XPxknuU8v2wd
 U2Wt9Gmi8wNDG6TlPow5Q2G1a1eW0DBfm5VNZ7DpQZ+OyOMTW94HMEgL9thuPaVB3l54
 d94zFOPr/p3QTHnwgy7lr/q0N0zEk5YEEXx/RLWrkniMffrJ43jQ8EE+qTW7175f2dKQ
 cTOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=MWZLNPG/yu21CFjKEtT3reINRinmw317B8AyEMtABus=;
 fh=xWSkzQgsBXu3+20YnzBfal+nvTG8YYutGQdtbnGx0RE=;
 b=qMMxscJe6dWsaYNr2IlYHH9x8HzpwyvklPpYfKvGcza95DtHfg5yL/gQ+9HjnMEyGm
 KfExXDP4rn0fhIVELZG/XR430E2NtZ4TkiFSyQOs3BcItWFPbRnc81T8k+QpfKMywTX8
 xXCCT2pO1ifSrkl73jEycT/NNHfhkhxMPRe7fviAMMqF7WnZK6cJdLFdCd2udy0NO5/Q
 DV7jeJZ/0S8h5zn/1hIHVeQZF9Vsd+FWQlJ/14lhcZv09vOZLXqb8XQK4XdDFeIdgFm+
 Sz1rlDaxBnM9SvSCB0QnmP1q9gN/GbBq1rmvOAgnSNV2475REPXzeFAzVBLGc0FqXhW/
 WK9A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785260648; x=1785865448; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MWZLNPG/yu21CFjKEtT3reINRinmw317B8AyEMtABus=;
 b=EhDtjuBiobXD0u7KJQNuSWlMGUBWS9m0MSxgBKbUHTVTeqy4N1FB70/Ir5iJe8In4S
 sAiV/laX0fKDSeltKy2FUIo5s0aAqL9UjOFXmkioQiSZU3EdbwsrxI1NUCr+uqAZNFlJ
 ypPUly+M+XkJ1sF5SV9WG+yaGOIZ4idQIL79nqucRbSf53+ZT1sN/N1EzjmG/ghTEJ8K
 +Z+W6i4PAP5tcgOpLkMiMZnb141dofzx76G9BZNMJ4f8cittN1TV2cu+FS3tsEMhewMI
 dcm1TmC3iiXMZ9jI2xbh9uxi97zQ/HtYPWjkoztUxtUYqxTTe91d38tzWC70/PWRnbtK
 AsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785260648; x=1785865448;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MWZLNPG/yu21CFjKEtT3reINRinmw317B8AyEMtABus=;
 b=dt2UW3cbjWQ7Lo19bMbTJTSLo99xUtBWwlqf8kxhVJeDEW73IB1X4CMzZivaMDGYYY
 VeJXV3ydb6nc4GGKko6Lq/BQwuqkrPQsT0mjkdz1jBRmaHwLeZP+6R9GQj1RibR70A99
 n0Ia+W8MnMBi8lYfq3AYFsxLLZJy3vq5f3K3//KWRxQmIf9E/cDbZUzirgH8vvNkNEJt
 eoI8r0bdAp1L/WklHEiSJTaoEMgDW1hshjB7JeKq9tYn2RzRSZaQ9H123/YTBZvPELAQ
 7wNF+zFXa7+QE0K6Kpd4iBlGPazRvTkjVN5FUsvsTEQXFZvZ+3/OHcPuMe/OS+PIs/9Y
 T8Rw==
X-Gm-Message-State: AOJu0Yw5oafB4SQ5AfhIMNhRypY0m1sDIb7RIVxtlN442DOEUqlxXhk2
 jNNiuefbii0NcV5Ljlpm2ZmHlbxrllpmn00N5/OZm65h6FrV9xrSFlMyu380qTt4kZ3XHh5GaTu
 1zEXokXD2zG59kezErGQ5oxMs7USoUtw=
X-Gm-Gg: AR+sD109k0k1AcShVerl5hrDB66OCkG4Ow4B57vA0nN298HDt4pMPmhOAOEvJwVd9re
 h6apBLnRe6ZZOZ363tdNAsRpi+7KEYeSIMPWSct1KvH08wiCn7Te822PzGppWMwL8dRoelgBTxK
 NyN1nn0W4juwTkPwXQ8nrmIX45PvXeVaqNHRvOJRHs3Go8mtioCeK59y7u+PP3/EbcOfqrAYkiu
 uAOE3L4VWqbXJkITslq8OCKbQrsu9reTmQ7EXADHNsCaAK7CDMoS9eulA1F/Q3427T1QfhC+mwM
 7bUdE7qEFy8Nz5aUcgw=
X-Received: by 2002:a17:906:6a27:b0:c1c:1fbf:5d18 with SMTP id
 a640c23a62f3a-c1f71b3ac24mr177554966b.3.1785260647519; Tue, 28 Jul 2026
 10:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260728163919.369020-1-mjt@tls.msk.ru>
In-Reply-To: <20260728163919.369020-1-mjt@tls.msk.ru>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 28 Jul 2026 13:43:54 -0400
X-Gm-Features: AUfX_mxS4Y6mtUZOMHKOSSWWC0aqFEqYiHz60dAPyxJFTeMBCa1lDe9AzGHHUC4
Message-ID: <CAJSP0QUxDeZTcEqHAPMVYqQ2LyeH9WcTbneosC02u6vubLMgBA@mail.gmail.com>
Subject: Re: [PATCH for-11.1?] qemu-iotest 161: fix race
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=stefanha@gmail.com; helo=mail-ej1-x62f.google.com
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

On Tue, Jul 28, 2026 at 12:40=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> w=
rote:
>
> qemu-iotest 161 fails intermittedly due to a race condition:
>
> qemu:block / io-qcow2-161             ERROR            2.08s   exit statu=
s 1
> =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95
> stderr:
> --- tests/qemu-iotests/161.out
> +++ scratch/qcow2-file-161/161.out.bad
> @@ -34,6 +34,8 @@
>  *** Commit and then change an option on the backing file
>
>  Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D1048576
> +qemu-img: TEST_DIR/t.IMGFMT.base: Failed to get "write" lock
> +Is another process using the image [TEST_DIR/t.IMGFMT.base]?
>  Formatting 'TEST_DIR/t.IMGFMT.int', fmt=3DIMGFMT size=3D1048576 backing_=
file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1048576 backing_file=
=3DTEST_DIR/t.IMGFMT.int backing_fmt=3DIMGFMT
>  { 'execute': 'qmp_capabilities' }
>
> This test is run right after a previous test, where we've
> killed qemu process which holds the test image open.
> It looks like when the next test is started (with creating
> the image files), old qemu is still running, so we're racing
> with that qemu, and qemu-img is unable to lock the image file
> properly.
>
> We can add some `sleep $little-amount` here, but it is simpler
> and more reliable to just remove the image files, so that new
> ones are created.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2867
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

