Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61280C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 09:27:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp242-0006nh-TS; Mon, 03 Mar 2025 04:26:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp23q-0006mc-HY
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tp23o-0007Xi-KN
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 04:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740993962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=165J/AJKUbd//A+p3/hEg+MGwR/Oh1N1lx4XQoUj4HM=;
 b=PyiuV9v44PPu32qDwBcimr8cctdJ+2PtiwIVjLoG26wkGZwHxbT07xbB647S6MtyDcCw3P
 fz/sYDhlOfNPVARbkZqHT0GyAgN4BabuQo3JCV3oPjy/OmguVdX8ciKSEDcMjVCm8jgrrC
 O/tjnZo8smMyDBMkrgp0sYn7lBGemPs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-107-ZBmIrDFdPPi0tP3rismujw-1; Mon, 03 Mar 2025 04:26:00 -0500
X-MC-Unique: ZBmIrDFdPPi0tP3rismujw-1
X-Mimecast-MFC-AGG-ID: ZBmIrDFdPPi0tP3rismujw_1740993960
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390e003c1easo1875797f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 01:26:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740993959; x=1741598759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=165J/AJKUbd//A+p3/hEg+MGwR/Oh1N1lx4XQoUj4HM=;
 b=rf1W/eDGCYQGMGTD1V8AXIqorjJhWVwRm2m/L3m6EeWEpxR5GJKmd2KFrlrn/86xXp
 L6pKL0CHEDlF5ktMyUxMUuh2O3Z5HWVUUStt97f9FKri1j/GpqaVgoBn364QP48PSJz6
 JaHxyC9tg62/ux4aorM2GXDUHZs0Buj8DETpKDvMPc6bJqiO4eB9xMHY1ihlUDj1BOOJ
 dPPWIc4KgWO4Vzff7j2Jw8scVuX3ktPapj29U1bbIMVtJ0Oi9xXuCCOcfxl63gQswsZo
 3VaS0Bx6rEC6fJIHYmL+gckVRrrAJ297+V/+xaqXQgtdP0NbFuUnon5Eix7yfCiM3d4D
 oZ1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNwKqSpR5U7/cQ+PHUoUjwHdmd5h/TLKE5/gyna7a9gfcYFcIpj7BJHaVpopJVMP709bL4QC4p5Lqx@nongnu.org
X-Gm-Message-State: AOJu0Ywhvhtv2hmDLuYeBwDGC8UbBh+RU/dyUONJJDReYQG8r+cWF6sf
 G3zpTErv0KD76qSYgew8etGTFOH6J+rYlW8c92VdBDEdvPWERJKBL9y9mgxHuz86voiCIcMyfn3
 vkykHLjsHIXwVcqag+ZTxI4WFclLhgoMgtzyO8qhzdNIay4/2eU0jf1E/fwokUw/5rmD9oTEruL
 MURraw2RtnfsGgLWxHccHOw0ARO+w=
X-Gm-Gg: ASbGncuVe/KqdyRVR09DGMo2pONMtyhX6OBja7ajA9u32jjNznGIxek7wh0NKXqU9qm
 8+EpDWTAnZaQn6NNVTzfpgT17gdqms1aT4WBZe6dgeJDEKQxa38GQKpvQgvGC9VT47pjsrvW6
X-Received: by 2002:a5d:64cf:0:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-390ec6e45e3mr10090415f8f.15.1740993959557; 
 Mon, 03 Mar 2025 01:25:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLx+OS36++1k8zJ2mlSzoiZi73ZyBslrQAuLa4k+QynfivrJGhxymvfTZHFnK3waw/I8HSz7owyCnwzkcXc8M=
X-Received: by 2002:a5d:64cf:0:b0:390:ec6e:43ea with SMTP id
 ffacd0b85a97d-390ec6e45e3mr10090397f8f.15.1740993959268; Mon, 03 Mar 2025
 01:25:59 -0800 (PST)
MIME-Version: 1.0
References: <CAJSP0QUk77GViTBgBpfYH-AbAmQ5aUwi0K6UTH9iv=1mVb0Wbw@mail.gmail.com>
 <803732f6-6ab1-4298-a956-660496664f67@redhat.com>
 <CAJSP0QUN_tCSZ=WOk+C9kR3TMqkTaZMNF7qaAsFPiauzN0r_QA@mail.gmail.com>
In-Reply-To: <CAJSP0QUN_tCSZ=WOk+C9kR3TMqkTaZMNF7qaAsFPiauzN0r_QA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 3 Mar 2025 10:25:47 +0100
X-Gm-Features: AQ5f1JqSAO2sknHP0Kxzt5KtAb_w2GurXh3v3jp3cYXnh7orjn5gJMVScg_2xng
Message-ID: <CABgObfYJTPu=sTK5UG2d28tTYrACRaiqU6Wzh_0NhwdnQmg74A@mail.gmail.com>
Subject: Re: Kubernetes gitlab-runner jobs cannot be scheduled
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Camilla Conte <cconte@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Mar 3, 2025 at 8:35=E2=80=AFAM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> GitLab says:
> "There has been a timeout failure or the job got stuck. Check your
> timeout limits or try again"
>
> Duration: 77 minutes 13 seconds
> Timeout: 1h (from project)
>
> It ran 17 minutes longer than the job timeout.

The job only seems to have run for roughly 15-20 minutes.

I am not sure what's going on, but I have opened a ticket with DO to
request both larger droplets (16 vCPU / 32 GB) and a higher limit (25
droplets). This matches roughly what was available on Azure.

Let me know if you prefer to go back to Azure for the time being.

Paolo


