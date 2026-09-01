Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EF9C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 22:12:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1WhO-00022Z-JD; Tue, 01 Sep 2026 18:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1WhM-000221-Px
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 18:11:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1WhK-0005Ms-TM
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 18:11:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788300677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QEFCNN2LckXdbe1klCa0jvrR3iMS7ZADwKbFR/sVO1I=;
 b=hN9do90iGshnJdl/g4cgSDyn8q9NdFjdOJ6Zi3sOc4M9DxWYBYduw6VZy0rWaNAEztZZ2H
 ofT5ygzSRaYhQDObWiyFNof/IsSzQSyGt6qR9yGGv1KeasmURzxuWdcRg9s/mbAsmfP1Ap
 PJpfWjLWNOonrxKllA2VJOnQKUZkRiI=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-z8r9nt1nM5KERrRfyNg6hg-1; Tue, 01 Sept 2026 18:11:15 -0400
X-MC-Unique: z8r9nt1nM5KERrRfyNg6hg-1
X-Mimecast-MFC-AGG-ID: z8r9nt1nM5KERrRfyNg6hg_1788300675
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-81ea59b5979so7901847b3.3
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 15:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788300675; cv=none;
 d=google.com; s=arc-20260327;
 b=AfyGsQC1GdD5aRR9rls+PA55HMfCGgR7keW3kIWiDQbuSFp1MLXjkg5UgN9RC+88ZU
 1vnBDaWHiXeYtTp2/LL3Al3qvA1FYGO+C00iPYKq4+hIS0KA/8bVwgq3wmYhhwFC/j4N
 xlZ9C1BFb3XfABvMCp9T3jlUy4aLc9DLxzKyxFhuZ0i2/0ZKaVofVSvzjGD2VHARJnyq
 WzvXlvu1c51LqKgeyFZuS1v4pcxB95B02l164qpwA+FveD/N1ns9ZGTUZiNL8cMIDNC3
 mhStjREoIGvjbXtqT2gGDCMiT6jsQMzMRQG8Z5f8RgKbaGt9SMCIZQ6Mb3P1C2ng3ZCK
 EUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QEFCNN2LckXdbe1klCa0jvrR3iMS7ZADwKbFR/sVO1I=;
 fh=ZVbG+wZiL98MrptYcscNwmP0w5yEEHjRC6ctslP0Hpc=;
 b=sdOtA2ao/jXuUadXP8lLhx2t/8tQRteSYSPx6O8R4o4Mc38kmkCU9bMVXoOT+8ToB+
 pGy/qP31lNkqMNCvkEA706zHKAAN8/EGc7Cq7MQtAnbgYb1zb37zF+Dnp/0G5C1eRYX8
 uKwOL2jZGg+dk2JYEB6AkZk/TmOY0Pz+veI0M1kDA2Lbshpze2DxEjLqGHUOmB7NJNIt
 IPebKcHLrup0yytHLGXyizTW7WBU5R5hC92/iB1E7duVisuzVL7/F0stEZz1Mu9pBxld
 UTOvj3S+k/DHnRw+DM73xaWgFFjVoaKeuPd2lRaF+AS2sMe1CS23P6dhMwdu0kVwBxcy
 qbwA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788300675; x=1788905475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QEFCNN2LckXdbe1klCa0jvrR3iMS7ZADwKbFR/sVO1I=;
 b=q+hW9srtLC8q3oBNtNXGlZLJT0kAbPbLs5lPZlEg+JO3VL9E8ZYC9XhaC0iz31jUch
 l05l1feVsMEwvuJ+bbmxpCdNZeuEd4znEY/T3NzrxrXeHUY2QN3eKvtfDOYVmmz9KZ/F
 iBSlaehwKlkUZ5Vi/33KQ2snUTZ+PzZq15JG634O5kb1Q7GwIpzd32XBXK0hOsbwMe0y
 xGWVIiAh16qe88bES0drKHmfIohQqGzzgS1iSTYrNy44kgR7x+dJ9BryVi9l+DHwReEF
 9FpF/8wkofvtgb887zjgA0ed9/kqefKP1+Woe28eJA97sqX006OJWS+ULZn6kqzLrT8g
 CQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788300675; x=1788905475;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QEFCNN2LckXdbe1klCa0jvrR3iMS7ZADwKbFR/sVO1I=;
 b=q7dq1t2kQyJnNEPOzqcuBmstHqZRFwKRYsltX9dgAo1N2NuatKeaY05VyBL1z2Nnyo
 E6wfOQI4sIsKBwrdalS/FBbrnTYcOLg+GOUVENJ+tvFkOjS+RpI4LC/6guY1gyR8cbtH
 qyiGWcZLB7akSlBUgFEfjNjixuiJpUC1u0Z+p06pWLf0bBrkcvlPIlRz9lgKhj1TUgrr
 82AKf6jLerDv2Fi9526YX1WBRDlaFUiW8uETOMat74DxOOZcGPvinRisYXAr8qVt28Te
 eSAOeWar8JdprzYIicdmVWlaEtfzuluc5gTW3dwARTkaxgrhyxe381l46T1arMe3bjyu
 Wmkg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzFaCTbDzez4rjAHsqeqka2Psl079wTXbbULXUygItiI3G1R4sTeL+XSdHFasvrvYTRU0dZ+yghR9yW@nongnu.org
X-Gm-Message-State: AFuF++mZbVEwEmZpvtj9UT15dvWLMUT1y2blNXwjkk1TgSLhrFwGRYa1
 Sl2bd5kZDg2gjZi1+zU3KoVjO7xzXXCrQUJoSEXUA0O5FzQgTk0kFmFGt/Ufjr3EtBjXJu0VZMH
 MNoyn/by40xZwKnQFSHE9IgRkr1a0q/uro+Y3ZPhmbs4nW/FgCHL+M1CyEML0kxsOujq4Dp6SZs
 C0FsRGp5tqay2Y6gWZZexg3/83zGUsprw=
X-Gm-Gg: AYBFou3IM05/1Dt/Y5hwgQe+bDNIOV/tiNJOMAwL2M+bCYR56mV3XxttsQAxNoGHVXw
 BUjNdsxASMmENVr+4QEIObfe8HPbntfi32Fz7AZFwMK6rKOAi/cQSZHGhVuKO7dd6KiUbtSc4d9
 SNpN5hKmGDvqvn1D8uX41eBUvveUMErXJZak++gBySVKQG24ZWVXObxw==
X-Received: by 2002:a05:690e:b47:b0:66f:860e:7f3c with SMTP id
 956f58d0204a3-66f9ba40fb7mr140463d50.14.1788300675018; 
 Tue, 01 Sep 2026 15:11:15 -0700 (PDT)
X-Received: by 2002:a05:690e:b47:b0:66f:860e:7f3c with SMTP id
 956f58d0204a3-66f9ba40fb7mr140418d50.14.1788300674438; Tue, 01 Sep 2026
 15:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260901195334.463267-1-jsnow@redhat.com>
 <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
In-Reply-To: <CAJ+F1CKA-UPwzx7XLLhvA+VW8PuDQGbXKXDBK0mVfo0E4C6-hA@mail.gmail.com>
From: John Snow <jsnow@redhat.com>
Date: Tue, 1 Sep 2026 18:11:03 -0400
X-Gm-Features: AcwNN1XccOVlfR71w73uCWVf9-55ZT96WKHUXz-_UO-VaB0ZmhDxyhvs4fTjnlw
Message-ID: <CAFn=p-Zix9rEXMQsCj=zanoOUXbS_dSTnWY3OaiLRSN4viTtjA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Remove stale contact info for Stefan Berger
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>, QEMU <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Tue, Sep 1, 2026 at 4:18=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
>
> Hi
>
> Le mar. 1 sept. 2026, 23:54, John Snow <jsnow@redhat.com> a =C3=A9crit :
>>
>> I was unable to get in touch with Stefan and I am not currently sure
>> if this module is maintained or not. To prevent an avalanche of
>> bounced emails, remove his contact information.
>
>
> Really? There must be something wrong. He is a very responsive and active=
 maintainer.

All of the emails I have are bouncing; I hope they turn up! I would
love to be proven hasty.

--js


