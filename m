Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B141ACD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 05:45:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN2Ov-0004vz-Ge; Wed, 13 May 2026 01:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <antonynpavlov@gmail.com>)
 id 1wN2Ot-0004v8-F7
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:44:55 -0400
Received: from mail-vk1-xa32.google.com ([2607:f8b0:4864:20::a32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <antonynpavlov@gmail.com>)
 id 1wN2Or-0007ph-NY
 for qemu-devel@nongnu.org; Wed, 13 May 2026 01:44:55 -0400
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-56a9076813bso2591879e0c.3
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 22:44:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778651092; cv=none;
 d=google.com; s=arc-20240605;
 b=GIn8lVpN0hd3qQ+CXE7UkWdQrgLB3okxlJa3yHI+9wIMPLreJ5LIgnTxKXzk9SEpjT
 CmNkVzERW7SJUVr4OEofAdnzMvbvKVnSUIeQcrR6C1if6VwMa4KhCldmGo1IotA/RY4Y
 yL87EaFkWiMkxHjwZJvJUkhJW7GeoFX0Ej6I7PiPaTlePpquz551xzkJ/6ZNwUdx1CaZ
 KDr+PnWPLH5jf2rYAiAbnM2HilwF4gcOXH36XDNQ1NwqnVVpMiiAzNEap1Cnefe6Gj7L
 7QQoFM6BCAMAPhcyRWPRLYrD7vQywxxuaWTtuzURaA/cUKRzi4pVaf6Ip6jV38K85BuG
 YoBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N4StaYjqLf8q5xOtfeKcrjIPhzz9SFFO0vAlI5ZEF1o=;
 fh=nEFwNNhUeRNDeevJ8lFHjI9cySMY9zovVgM9gXagrv4=;
 b=eYRw6o2TrHZc+L9vnDFDiWhq4BQuV+4ZxDS73Y8RGMk0LWzOZB5i0iyTHisMhWozvO
 vsiKKUgqnR/rymmWR/Q3+gtbG0cHMKttquv+0bgYngZRQOJyF2dQpQ9VkjShihu7LZeN
 fEy0lBuNrPjavAzMfazvn9u143yxFhs9wtzbFikBmyaq4lAq/V/NEVMN0MgjPk4nzmBm
 lbTBKBdGExwn19McsEsL1BB//d6s9QL+9sge69LbZzIENZhpWmu3ORCctDy3NASJUIx7
 H4phKWcpUJgAGzTWdSGjnFQCcp+lh3nqAjMVTHEDP5g/bvkUL+ti2gTZZjI185ADCO2N
 M2Bw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778651092; x=1779255892; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N4StaYjqLf8q5xOtfeKcrjIPhzz9SFFO0vAlI5ZEF1o=;
 b=PJYHvHJ8WTU51dihjqK2/5WZwhKIm8+mQtl2gy5hMRICA0R5inIoLi+ne46MUsbExM
 2tXkclgWLEMTDIkg5zPSsefp4a48crrgEY7oEk9ib7iic2tfTap8T8osGwmR+sIAKLGJ
 ykEEhCOR7Msj64UQLG45ormt63V6hRDIsaSKNVVINp+DNeaseGJT5+8RUASc5xnIJZav
 GnZrUqG74hoiPpeJY3N0vZQl1s06TJfkQg85vEdc5nN5Ch/6tGUq8HQtk64wfrnCgGvr
 yBoOpsC5uqkwuITqtMSEQe3CNb9S7ssg8FGudLOZP4rEwsdLznSZml1VDbyKgl5viNVD
 o6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778651092; x=1779255892;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N4StaYjqLf8q5xOtfeKcrjIPhzz9SFFO0vAlI5ZEF1o=;
 b=rASrKToB8vMqwCfcF0K6ZesMKvGGxYJ4Tw5t/IYDm3uDz3BOYLsmfHSZvhMan3XbzN
 nCECjHL4fjAanUvFb8Hb1LD6+SFNaZXiNEk/Gy/JmlkjiqaxMaPScjPTbZOoxbDTInM7
 hv+utTW62bIdhrV+267GOwe7sRBoKOiEVZpvyarLmRGXeEfm/7keI6db8hQXPR4zpk8U
 pnt8zYio+fMOIgml2zcDD5R3EaZv175gQBPHpZp/YtaCsCppdWMZb7UvFrSmK4S/13Nq
 5NQaapHtW+tIP9EiM3JHKcKjOuxsmyXToEywRHXto9gM1ZL9UQDXqvJZ8b75T8rfjJl8
 0kcQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/YzOJFlUTOksM6uqV2RpY9k7j9ZT10MDcBX8x5vF9qsL7zsZcnE5Wk7JoQEIYWyxmX+ZXorRq7Xezz@nongnu.org
X-Gm-Message-State: AOJu0YzzRNN+/0Gg6+iMnamE3q3VNpGPOEftTIpN/g/aq/bpJRDD1JKC
 DD4GVMHaWVMM/yCAmYhLbEG2rTzpWqBNX6HkjkJOwt7n6mXbq2WEdi6SW7GiBBXMl0kvrROKz7G
 Q2ATG77E6ScKCAXioM8Q0JvrksL8nyAw=
X-Gm-Gg: Acq92OEBInM2Z2MgNZuoTwwSE9BnUKKScw93se1JPXciVOAQIXC+1VNWnQklEueP4wn
 YEI/O5oc2MSz5IWsQUsR8en4BxYWO7OkDsFoswbXuuaTIBt96ZKF8pyEcOQRCKm0Kn1IRzKCMtV
 f7QMNVmom+bp6r9ASL5+FtIEy60aCl+ZVlhXnDLYaWHXSfAd+BMUNg94fdjRU9TmnYYRgoxBGUt
 lEPqsQIz1kPqmlHBaUXn1LuSasZiznPxfDTOHrHNwEilxuPg1WHuz/BBUFTk2hKHBXC4iJADx9w
 U81YFRY=
X-Received: by 2002:a05:6122:1791:b0:56f:2609:cd95 with SMTP id
 71dfb90a1353d-575e7165181mr704669e0c.9.1778651091966; Tue, 12 May 2026
 22:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAA4bVAFS4aRjW7On7C0Y5MQH94TmLfXMwcD+8dWzKBD4JZL3Fg@mail.gmail.com>
 <9a6f4a8a-9917-4384-b36e-9eafe2461725@linaro.org>
 <CAKmqyKMTnn_oVUhKDCBkCDSwivgnf3U0hcyvUEkfEOcMy53m9A@mail.gmail.com>
In-Reply-To: <CAKmqyKMTnn_oVUhKDCBkCDSwivgnf3U0hcyvUEkfEOcMy53m9A@mail.gmail.com>
From: Antony Pavlov <antonynpavlov@gmail.com>
Date: Wed, 13 May 2026 08:44:26 +0300
X-Gm-Features: AVHnY4I0f8cheblw_iX72vfxlsFuOTHM_sSBpbiAF7Xqtq2_c6lCnU6d3dsUAvQ
Message-ID: <CAA4bVAFMbiqZvBeDDYYjHAX_Zrw_k+5mD=baxdSSyBe-KJiRhQ@mail.gmail.com>
Subject: Re: target/riscv: rdcycleh problem
To: Alistair Francis <alistair23@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, 
 qemu-riscv <qemu-riscv@nongnu.org>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a32;
 envelope-from=antonynpavlov@gmail.com; helo=mail-vk1-xa32.google.com
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

On Wed, 13 May 2026 at 04:50, Alistair Francis <alistair23@gmail.com> wrote=
:
>
> On Tue, May 12, 2026 at 1:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
> <philmd@linaro.org> wrote:
> >
> > Cc'ing qemu-riscv@ list
> >
> > On 12/5/26 02:50, Antony Pavlov wrote:
> > > Hi!
> > >
> > > I use qemu-system-riscv32 v11.0.0 for running this code:
> > >
> > >      15258:    c80025f3    rdcycleh a1
> > >      1525c:    c0002573    rdcycle  a0
> > >      15260:    c80027f3    rdcycleh a5
> > >      15264:    fef59ae3    bne      a1,a5,15258
> > >
> > > The code is recommended by riscv specification for reading 64-bit
> > > cycle counter on 32-bit system (see
> > > https://docs.riscv.org/reference/isa/unpriv/counters.html#7-1-1-zicnt=
r-extension-for-base-counters-and-timers
> > > for details).
> > >
> > > When running on qemu-system-riscv32 both the rdcycle and the rdcycleh
> > > instructions read low 32-bit of the cycle counter so the branch
> > > instruction always go to 15258.
> >
> > Interestingly I'm having similar 32/64 bit conversion issue with
> > the set of CSR functions in my single binary prototype due to this
> > target_ulong use.
> >
> > >
> > > This quick and dirty patch fixes my problem:
> > >
> > > --- a/target/riscv/csr.c
> > > +++ b/target/riscv/csr.c
> > > @@ -1389,8 +1389,11 @@ RISCVException riscv_pmu_read_ctr(CPURISCVStat=
e
> > > *env, target_ulong *val,
> > >        */
> > >       if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
> > >           riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> > > -        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) =
-
> > > +        uint64_t t;
> > > +
> > > +        t =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> > >                                                       ctr_prev + ctr_=
val;
> > > +        *val =3D extract64(t, start, length);
> > >       } else {
> > >           *val =3D ctr_val;
> > >       }
> > >
> > > Have you any suggestion?
>
> Yeah, it looks like a bug using the `target_ulong` (which is only
> 32-bits on RV32). This is something that should be fixed, if you can
> send a patch that would be great

I'll send the patch within a few days.

--=20
Best regards,
  Antony Pavlov

