Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18288C5DF85
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 17:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwjvl-0007xk-A0; Wed, 19 Aug 2026 13:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwjvj-0007xW-RK
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:18:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwjvh-0006c0-7E
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 13:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787159900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DmaBr9aFjJS5PQEJTqgq7VvB6EhExuOYpluKGSGAx8A=;
 b=bKaxOPLjeVYSiGZrgMJ4dgZFUydIm4lWhzXxSP2zCHKt8eEcZ3XnoK8GKMvy/Yjcwcqd8B
 cZ7aEfctRHwpUgrFGkSqrmfKjuh051KATClKo+1juDXsGbQqE5AKB3/nwrknuINOFX5Im3
 1V80pJqCRTWTA2pJz2w3KmaUh/NZsd0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-S_vp_ZyJO8O1mgEeLLajjw-1; Wed, 19 Aug 2026 13:18:18 -0400
X-MC-Unique: S_vp_ZyJO8O1mgEeLLajjw-1
X-Mimecast-MFC-AGG-ID: S_vp_ZyJO8O1mgEeLLajjw_1787159898
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-934963b2bc0so138021785a.3
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 10:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787159898; x=1787764698; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DmaBr9aFjJS5PQEJTqgq7VvB6EhExuOYpluKGSGAx8A=;
 b=nVGuIvllrl57Uq8Y5J30WeH+P0hb9Iu4EIZa2OLx8qk7pHm+4cQRUnRlLpLpGRFDby
 ZSm2wGVMily9Ejwlg1Zvio30pumv4kW7rT7coU7CG4XVX1qX5GHVuvN/xjSINtT1MOxf
 OGpEzm/VmjqOceaYnr+EQgl634znS/flSFYHVi07QmzW53TQEfHbTfXiu45ii/9iBmC+
 lV2nGr9wxGOHhrT7P2ZW/1pgG0JyeiEiVLUl0c/balozODYsuQ+UeLsykEkQITFSm4VV
 6XvCCVXEtkVvIdhhnwgR0kHQtR0jhMsJ8EKsEuSta8r5HHggRQhScDj/4dgCZCJRQwN3
 bphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787159898; x=1787764698;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DmaBr9aFjJS5PQEJTqgq7VvB6EhExuOYpluKGSGAx8A=;
 b=XI4pfj4f74c4qdNdSH/RnYRip6+0s7N5YAzCSY+6sNwcZ1gZHvKFRTSCfmALdgKzXe
 ehrZu4Ag+5k9oO3SL9ZyId5r5Kqk4jLLp9s1CvU/i0S1206vl0vhb+MWkK1TByMCzYJb
 vF4CGtKpsn+pNdyiqBcxKers7tPKneImZfcVPcenaTRvizHaCoFVwxKKKWBCloBr3RzJ
 oeFvneKwvXNjrDbDPnKpXNkoK0glLezOwqRrDdniTUlb5zAB1XJvkdjgCmuEIOCtNGNG
 zW/vSxE/9gwLJdNBju9IFi2rv9yrpCDpZFTBx7ApJpvAD9+7OOGg615CS8sgsLBckaCA
 QqLw==
X-Gm-Message-State: AOJu0YxfdY6uAMARmRH+jwsoBn8KAQ+BFj9jCvyFzHswlv9U10idiXbJ
 SlJH37LIbEz1I8elryELCRfpEimSZK+82XHmY/vQksI82F/A6K9Oes+gq9+Fmnk2cUCvg71vS8r
 /G+wOX7Jr9IIEm3hx7qGL412oCFDjbFIDGrFh20DmsGy9ym71ZTcpOTqy
X-Gm-Gg: AR+sD10VkD+L0uCV2ErJpgKu2ebVBMntpLNHJCiFZ3J90XxAXaZgnSWEexTkfOfX0jS
 nxcZiWEsW7FAdQjkEXC9oNzl8XXFN9k/gzTqmP/nt/uNtAYYjdnknIKKIciEuqvLOZrgCC4P/aw
 JPQvdBCeKfoOHAECebYMJzOUF8G/Vg2zX8hGv/e8EI29KxRyFLDwua1DuKCan/5AMn5Q5u3XKRi
 UR+ZiFAN4GCNy59wxBmAX/8O85UysGbWhg2kpgNlztISx3htM5B2ZZsfDYbuDjrjRunbknFFqd0
 YaXBDtwGoX5K4DY7JJnA81rwmIoZcJBGcoytKGnkjmKtJXob8Upe9LDSn4VdTCBMJgB7
X-Received: by 2002:a05:620a:44d3:b0:932:df51:5172 with SMTP id
 af79cd13be357-9371e677565mr562122085a.42.1787159897880; 
 Wed, 19 Aug 2026 10:18:17 -0700 (PDT)
X-Received: by 2002:a05:620a:44d3:b0:932:df51:5172 with SMTP id
 af79cd13be357-9371e677565mr562116785a.42.1787159897239; 
 Wed, 19 Aug 2026 10:18:17 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-937205815d8sm176457585a.35.2026.08.19.10.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 10:18:16 -0700 (PDT)
Date: Wed, 19 Aug 2026 13:18:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: Re: [PATCH v2 8/9] hw/arm/raspi4b: Drop board_rev for 32bit hosts
Message-ID: <aoXlTZQQ-ywdCIAJ@x1.local>
References: <20260818172012.3052821-1-peterx@redhat.com>
 <20260818172012.3052821-9-peterx@redhat.com>
 <c5e8b837-5921-41a5-8314-d61a629c7057@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5e8b837-5921-41a5-8314-d61a629c7057@oss.qualcomm.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Aug 19, 2026 at 02:54:23AM +0200, Philippe Mathieu-Daudé wrote:
> On 18/8/26 19:20, Peter Xu wrote:
> > QEMU has switched to 64bit-only hosts for all system/user emulations.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >   hw/arm/raspi4b.c | 4 ----
> >   1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
> > index e1595a875f..5f7abbb4c4 100644
> > --- a/hw/arm/raspi4b.c
> > +++ b/hw/arm/raspi4b.c
> > @@ -111,11 +111,7 @@ static void raspi4b_machine_class_init(ObjectClass *oc, const void *data)
> >       MachineClass *mc = MACHINE_CLASS(oc);
> >       RaspiBaseMachineClass *rmc = RASPI_BASE_MACHINE_CLASS(oc);
> > -#if HOST_LONG_BITS == 32
> > -    rmc->board_rev = 0xa03111; /* Revision 1.1, 1 Gb RAM */
> > -#else
> >       rmc->board_rev = 0xb03115; /* Revision 1.5, 2 Gb RAM */
> > -#endif
> >       raspi_machine_class_common_init(mc, rmc->board_rev);
> Here I'd rather keep the machine. IIRC someone already suggested
> to adapt the board_rev with the CLI provided memory size.
> An improvement for tomorrow, meanwhile:
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Sure, I can also drop this one for now.  Thanks,

-- 
Peter Xu


