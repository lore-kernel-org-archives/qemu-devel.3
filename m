Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B2CCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 13:02:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRrOH-0005qa-SM; Tue, 26 May 2026 09:00:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRrOF-0005pu-Pw
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:00:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRrOD-0005Ku-OY
 for qemu-devel@nongnu.org; Tue, 26 May 2026 09:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779800408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wbwh5bRw9WH2JEokQvRX6X4luw5t9C6tMWl08EFR25U=;
 b=iVYPDI/Xay7AO1VX6cH1RcBmLmTnbecHd7c+OJ7MYnQzw+dIV5HlmEqv346DPRP/fDd6pU
 XLlQ4Hby2ZT9cu4FLZhwNalzsfKrkWnRbw/8HzSpIYowCn2GaH+58BZ34+xUdDwjW95jWn
 dMjN+jMQh9jcWUXRXzCwebI2inAOCF4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-Mu7KQpnRM36gplPsdW--Yw-1; Tue, 26 May 2026 09:00:06 -0400
X-MC-Unique: Mu7KQpnRM36gplPsdW--Yw-1
X-Mimecast-MFC-AGG-ID: Mu7KQpnRM36gplPsdW--Yw_1779800405
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-44d83e45febso7518445f8f.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 06:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779800405; x=1780405205; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wbwh5bRw9WH2JEokQvRX6X4luw5t9C6tMWl08EFR25U=;
 b=PCWenb09PMf8iQ8x4I2dtlD9wiQ0V8xch5zmVRq8n6lCaogo6MvJTgX7NsDcLh3iHD
 vt/qGXaPmpy0u2g7wvroy0SJC4KVnuaoppMT+qujKmqN6tjjNTU/H6cWdYGL5qe3j7ws
 CxkrRNb8EbJfzsFSQCrgsbn/NYG9nDHnpzyOaLpuZntf8XuKZSmq1ZZRjqkuPA802dgv
 CPveiZJXu6xDAzCMULxBTZ65rq0R0XKlZoLkRsnFSM92wSR+oyiJ+2Sxwmatincemmxz
 cvB04ncIdNqbQajH+Ok3E/EDoMzRQqTNOA52gXKppj7JhTBkxUIwPmPhWSB8drFc7VN0
 GWeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779800405; x=1780405205;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wbwh5bRw9WH2JEokQvRX6X4luw5t9C6tMWl08EFR25U=;
 b=gR3LSAt1+J6m/TLmastcR78hTh15ydZ8F065jOXRUX3FgWoH7Dj2GMDqW+TKi7fdja
 s5s45uMSAW1xx8HQDpfC7JMoSHISA4MU1hGQMZQ5CKFQ5IOVD4P5vBNdY6hzxEEms8d5
 hmfhoDa8i0F+pHdIvKM3MwXzouu8vewAw2QWbEbvs70BXBNqFY9Q2QQAwCP4tQ4a8OzC
 /JjNYQcNE4HEwCFXrg3TJlRkvhIjw+TOzSJv/2O3B/4Uhm0+MxiXnrMuM6G1McwcN1Fp
 jqB4IvQ15gYwfNXTx0k5t4WSfGRAWPHMwEqjPIef6uZWfUo3oPwegnEjKugK5VXG9OE0
 0wzA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ID3rw7PgZ0H4mMp3gu4HEOGpXaOk+qVi4YyCAk4BWqffxWpnEmIbaDy/rzfGHTVlB5CSXDarhmssN@nongnu.org
X-Gm-Message-State: AOJu0Yy/bzfIHPUo+M5U1aBBqQsbGbgNRyLaSSYzqchvdMTQUNn0/LRT
 85m/bVsppvrVjR+OV7W7jubIyeaDOkXz4nIcREt0R4UnLhO00J5uTDcVSYP1RZT4QpQWylImBv0
 0wNmR2Gdx+v2mP0L46hlGXpHBTBcCgnrf8L3zJSjmJyFQ15Soa0AFChV+
X-Gm-Gg: Acq92OGe16Pz9kaKhwKrBin+99dlPzcVyP7uPFhEtPguivUgrsW2URzpqIY5TkvhXP4
 GIdFKk4dh3PTfy1hkJd1SAx+MA9uVOyrmYLDirzsflPyEEjKOL5eXw4XVEqeqpb9kNc+qXVVPvh
 85mivo4Wab6ciId66Z95zcllRPd489ep3bnkcqYvNpRSwhjF8qvbNf3uRPv99YXldLW4/6SnNo1
 gbaXfqpaEefNCVKCChrvDia+f1aLwir5HzN5/5XKt31f+gop46a6Dtv5Oi5pf+Xjbh4dfvP7f38
 PckPO1EY+fSgfUbk1pUu3RevELswwaT7QMkq/QElp1qxQK+6FrXyWxLJX30wP3hWHQUGXt/zOUw
 uXc0zYHH7k8XukgrpxWgpW2Y9zHUa6c6kYOrGH4/lP8YuBt+qAO4shQ==
X-Received: by 2002:a05:6000:1888:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-45eb30cfce0mr28428810f8f.3.1779800405014; 
 Tue, 26 May 2026 06:00:05 -0700 (PDT)
X-Received: by 2002:a05:6000:1888:b0:457:ff13:b2a4 with SMTP id
 ffacd0b85a97d-45eb30cfce0mr28428741f8f.3.1779800404402; 
 Tue, 26 May 2026 06:00:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5e484sm34177302f8f.30.2026.05.26.06.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 06:00:03 -0700 (PDT)
Date: Tue, 26 May 2026 09:00:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 "Hajnoczi, Stefan" <stefanha@redhat.com>
Subject: Re: on ai generated and code provenance
Message-ID: <20260526085923-mutt-send-email-mst@kernel.org>
References: <20260524083329-mutt-send-email-mst@kernel.org>
 <f0bc9023-28c4-4685-b0cc-fc7ad4e6d371@redhat.com>
 <CAFEAcA9wMRFJWrjGHcd2nfhgXovyuS=dDJvCXWZkgmD_eez27A@mail.gmail.com>
 <CABgObfYSy-sctHcUW3hPxQZ8ZGOYHLi3HaW+FrEQ9kKitMAVZg@mail.gmail.com>
 <e875fb45-9697-a6d0-fbe0-d0531eb2c911@eik.bme.hu>
 <20260526082814-mutt-send-email-mst@kernel.org>
 <CAAjaMXYzNUG2KNWkOdH8Y5HV18MwxTVR2jVNPaP_m72VZb2P+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXYzNUG2KNWkOdH8Y5HV18MwxTVR2jVNPaP_m72VZb2P+w@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, May 26, 2026 at 03:37:50PM +0300, Manos Pitsidianakis wrote:
> On Tue, May 26, 2026 at 3:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, May 26, 2026 at 01:27:40PM +0200, BALATON Zoltan wrote:
> > > Maybe clarifying this in the policy could be
> > > done although there will always be people who ignore documents.
> >
> > One advantage of the linux style tags is that at least they differ
> > from whatever ai's put in by default. So whoever does it can get
> > banned pretty quickly.
> >
> 
> What would be the mechanism for that though? Getting the list
> administrators involved to ban email addresses from the list?

maintainers learning to ignore patches from bad actors works well enough.

> If banning is to be a deterrent, the process and rules should be
> codified in the docs so that it exists as a warning and there is
> little room for abuse and ambiguity in both sides.
> 
> >
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd


