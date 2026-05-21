Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85CDCD5BAC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 14:24:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ4JD-0001Vd-Fm; Thu, 21 May 2026 10:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ4IX-0001KQ-Th
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ4IV-000591-9m
 for qemu-devel@nongnu.org; Thu, 21 May 2026 10:22:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779373370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RH05gHQfsO6XxElUEre8MjkhjJLcn3LTyidfBnh+DVI=;
 b=Y3L1exh4pxt4nvTzy/H7VmRu7GYpyweP4giZdpzf2hscnSLNpZSDSFiXa2Le6m9fY7mJfz
 xe3N0WKMvNgjWCnqRurzuEfyxYi/pmf/0i+GYNlSe27RfrPM+MKu92wARQeVbpsgFv8KCb
 OT/y+G7gqPPhslM3TcoldiBwuEicpt8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-6ovOHBSmPzyGBwhClKHCDQ-1; Thu, 21 May 2026 10:22:41 -0400
X-MC-Unique: 6ovOHBSmPzyGBwhClKHCDQ-1
X-Mimecast-MFC-AGG-ID: 6ovOHBSmPzyGBwhClKHCDQ_1779373360
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-44f65835b77so4643979f8f.2
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 07:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779373360; x=1779978160; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=RH05gHQfsO6XxElUEre8MjkhjJLcn3LTyidfBnh+DVI=;
 b=CbdJUvNa4X66t7bgVIlL4kdK7OLZSrwuvEtsoKFhcr+2vFJ8AbWVhZfb8hShhWvDTl
 0KoK2AJeGUb8Y8Gi52kRd7UcHxSWknAU9oBJOTw84qAGEhHKK3fuhHC6Y8i5GXA4m46R
 gsmOa5G7g6xnNoQ8mPRhUAENN1x9t13/DgmbG8Fve5O4e2ZFPfNkPuyXo77/aTDkJJhq
 qTusAdnI6myb9bBnupdmjqCA4YiZbElKGeMk/6JdCV5oCu58UFtWYqRmzCEmmbuGonMH
 eDiODgMlU2R1sxA0/AuhEahUT1GPgT9kVA6PzN8HlRrxSyU6WWtsfoCt+y7QvMDPj7UX
 ITsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779373360; x=1779978160;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RH05gHQfsO6XxElUEre8MjkhjJLcn3LTyidfBnh+DVI=;
 b=o/HX6Vb9mrHQb7CTaYeokhe526BsX42G86RR2GCIdI0C2ViyBjJXoGEN2qCo2W7aH8
 dws/oCPjjfyekSJdPuUWlGJVlIaL0G4QF6bi/kQlRZTq/iMX4lZeefTBTsmjymtnY9fZ
 q53sWLGMyh6iFad1nd5mAP5qXqB86zPKyloqMfdKDXW3uJUowDczjZWE5UCcU36+z49w
 9gWwa51wth88P63R5K5lLVmY3tFrkAhKrpwh9HAF50oElvBtoRStWkDxJYDkQ3EQQ+dn
 tffxqD/ar1kXd6s9U75twxMurbpI4nPpRKHvc79PljxAYEhiGaJq3DHPsDDbRa4Gol7+
 6TXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9cNom804jUf4lELVppeUiWQHUjNmxXgyulJ3A6EGvzHt/L+5VC38i4sBPY1dsECd3HsMJD0lcJUTdY@nongnu.org
X-Gm-Message-State: AOJu0Yy8UD+zF2LmZ/MheU6IUjhAelXnDyLTkbrlhaY28qch4JqsBoxK
 PwIXbEoxcdGW63gn4g2S/sS2i69hO5nNgAJVfHd/JuzWTxR2r00b4z9WbEMk6M4SrvGJRIliRG0
 m7enQ/bGdIdCzyp59kgq4JQzYqK2j9kuXT/nrAQ+03JudKPA+8nO4kGub
X-Gm-Gg: Acq92OFTX+XmWGrzo+jrqeQZ+AKIs/MNfbWIG5Pl8KQJmEaCBem0zC/4v+zCNpz/r11
 iCye+82GrB0OtTniZeP8NVWYmC4iq/LW4GxnsIxwNSAYnxYhNoOIb0Ci5NY2joxxwsZenUkCJbp
 F2T9SJHM2Z0Px3ZiCnhnGCPHEouMT6gDF73I8c3+qzsy0WFjMTAG7MytQ3cm4pI8l3Xk9iY/S41
 4B2Mqr5IkysewqXt9XDyF6fqVtZEPVC+doI/1W1xbhlziLvU7oEF5W3wMlq+hIzUzVTg4+hXbb5
 roejoc965yYaBu3QKOgVB0hIz3sGy0sFP8yhfNq9Db3L3+afZcJ2xvAH9Xzgv7ENCsw8mJueALP
 pySLTLuM0IcSw77Ws7MIHkGkxjuJxhI5ALzyJCl4BHSj5bNK1RjYrcmKCgJxgCPWUFBLKDmE=
X-Received: by 2002:a05:600c:1c0d:b0:48f:fe2a:107b with SMTP id
 5b1f17b1804b1-49036048699mr56077795e9.7.1779373360385; 
 Thu, 21 May 2026 07:22:40 -0700 (PDT)
X-Received: by 2002:a05:600c:1c0d:b0:48f:fe2a:107b with SMTP id
 5b1f17b1804b1-49036048699mr56077065e9.7.1779373359969; 
 Thu, 21 May 2026 07:22:39 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d44705sm63687105e9.4.2026.05.21.07.22.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:22:39 -0700 (PDT)
Date: Thu, 21 May 2026 16:22:38 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 11/18] arm/kvm: Initialize all writable ID registers
 from host
In-Reply-To: <20260519132905.145643-12-eric.auger@redhat.com>
Message-ID: <f049616f-d221-5f0e-95a5-e40d61637e0e@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-12-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 19 May 2026, Eric Auger wrote:
> We want to allow overwriting writable fields of some ID registers.
> However currently some of them are never touched, neither read nor
> w. Examples are CLIDR_EL1, CTR_EL0, REVIDR_EL1, MIDR_EL1.
>
> We want to initialize them from the host value, allow overwrite
> and write back for kvm afterwards. This patch implements the
> initialization.
>
> Introduce a new get_host_cpu_idregs() helper that gets the host
> values for all writable ID regs and store them in isar.idregs[].
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


