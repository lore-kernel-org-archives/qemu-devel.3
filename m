Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 195D2C9833E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB80t-0005Fx-0j; Mon, 28 Sep 2026 05:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xB80I-00059k-Kp
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:50:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xB80G-00080q-96
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790589030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hnFYEnvq8cCyxNPeC5PMEQg133c9j53qRdmHxLfkrpg=;
 b=VCCIk31n8fPkXJzGqLQ2ZKYIid0+vYgcgKDE9LR54VEQ4muR8iOfNoQAqnAStIGKMmhaIB
 1Gtm/38RpIJZvDECCWwsOBZkoAUxVVY7WedPj6LDh5rYD36EqKc/pFlkQ2i6LCwIHagC2J
 o8jKMvey4x+5WJ2jgod0pmbGOBn3ZAc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-NUMTyHVBMVyi_Q7cEXbTag-1; Mon, 28 Sep 2026 05:50:29 -0400
X-MC-Unique: NUMTyHVBMVyi_Q7cEXbTag-1
X-Mimecast-MFC-AGG-ID: NUMTyHVBMVyi_Q7cEXbTag_1790589025
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48885f0ffe7so1123767f8f.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790589025; x=1791193825; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hnFYEnvq8cCyxNPeC5PMEQg133c9j53qRdmHxLfkrpg=;
 b=T4qqSBTM8g1wq1IrZFl+89DqbYmP72ll4tqjkMi2xYwuBgCK5RCXVh8CrBSHN+30Po
 L3mEbJ3TemNWGWjxaFXDS3MzQB7CVYDiOuBIv4TK4lv+bENySE2U33+5DYgvdKkvCLNT
 eV8LXjMa0aAq5pCCKR6s2EAuhd4WPpq7j2PinR52bP2oQF4/vfP1Gq72ztuAEMTG4oo+
 na1hSonxrR5rRG0ebgsCzdoX38UCfGPf93pHTzbZcYzyvGPNu4BtgeD+2snBOpmvgiUL
 /iO7xH4YBdOaShpVtWE9yhY8Rn1OK0YTKxYowrdmp9eS/jQ4oGGYctC+i0YAphXs+1i8
 DoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790589025; x=1791193825;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hnFYEnvq8cCyxNPeC5PMEQg133c9j53qRdmHxLfkrpg=;
 b=Ememj8rp78vqN26xnOqdZ6ffGl/fMcyYAePxTkLE2FEsqO7fc4cD2GFvfAcEWkw9hY
 7PTrg7HAUKbUw7TCOMMPjHEWQfKfn16TAwYcTmpJvePnoFBehz+KS7o1QiQR/hzHHpNX
 eBFBttXdMoSn3wAigkiw4WJSNIEo4i8wLPk6W8ccIaHVo6KNwaK5QeEZw/mmp5XUAuNY
 kT6azMrEsyIsuI1sve3N2keCSlPyuuA4JChQx+gveWGeZcPMqbZ4OqhHe/+vgJmr8BEh
 QKUx5Znd0KJINazg1jXOxHPcjeRwFGvDIrm95upYXN7cs+nf4neisqSpb2wb4bH7gr7c
 h3qQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBtT5NmjEKvWUVd8xfAswmRTOvjppzBLsv2lgPQPhXhG4822+1u2raMwoTatUhucEHc/7M9E3/6A95@nongnu.org
X-Gm-Message-State: AFq9FYKOjyZtE9w5RqGHSgBL8gFzD84bm6QnYS9rLObUZMXnIoMCznzw
 JdrnI/J/5iafpV1sZCTFVjU1VNnrCTs++etWLDfEqR36d8TfE7+wmaAE6f21a5AkQszWqzKXlcO
 8CKX84VDUS9psVMkl/ULiFMKWT3ywvSDWqaAJ9bsFNb+BcAvFQvww72Wp
X-Gm-Gg: AYBFou3vNAsM+68G9Sa1jWttd0IUKvKZ11MzNS2A71WvDmZS4wOeLuBdu8oFLnKCt5+
 rdDHyMSKlQ4BgqGzfgz/e1V3DhbcnEszXA1gw5EDk5LwhYhtC4xHycWRupopklG3bvyZfrAyii4
 1brPXw3Fv33Znc8GFrJw/5ZGHtUn/XqXsXZucTwQcNWKCH5hp6T7VxVC8dyHtbqlGpebdB7HQ07
 /qfMEkunnjpGwoOjoJlWWDjh/iT7qKFIwvq6aZkRYtYpqdlkid616Z2CoUshMxdG9v6y2JGeKZg
 xcNVH4mdgum85pvTXu6KwdGum8DSeQG5/KgTLbHhso2ER1bBSl8EhcgYmzCvfKE++IvU3ptyvue
 EJREcUh56G7kJsHR7h9eVqOFELIfqDvDlFK7GLYJK3no312vhfepL5cbJKGdPXm85HA==
X-Received: by 2002:a05:6000:2284:b0:488:89ad:56c0 with SMTP id
 ffacd0b85a97d-48889ad576amr9869036f8f.11.1790589025284; 
 Mon, 28 Sep 2026 02:50:25 -0700 (PDT)
X-Received: by 2002:a05:6000:2284:b0:488:89ad:56c0 with SMTP id
 ffacd0b85a97d-48889ad576amr9868989f8f.11.1790589024807; 
 Mon, 28 Sep 2026 02:50:24 -0700 (PDT)
Received: from redhat.com
 (2a02-ab04-0158-f000-2548-f3bd-8b42-b18f.dynamic.v6.chello.sk.
 [2a02:ab04:158:f000:2548:f3bd:8b42:b18f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6470b7sm26802119f8f.27.2026.09.28.02.50.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 02:50:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 05:50:21 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Cc: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Szymon Lukasz <noh4hss@gmail.com>
Subject: Re: [PATCH v7 00/12] virtio-console: notify about the terminal size
Message-ID: <20260928054918-mutt-send-email-mst@kernel.org>
References: <20260609-console-resize-v7-0-0c550fdcec15@gmail.com>
 <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6ac40a4ff79b9c603c7548acbd8fad9c0c44c87.camel@linux.ibm.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
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

On Mon, Sep 28, 2026 at 11:30:03AM +0200, Maximilian Immanuel Brandtner wrote:
> I would really appreciate it, if this patch-set could be merged. I know
> that things can get really busy, but it seems to me that there aren't
> any blockers that should prevent this patch-set from being merged
> (apart from some minor refactors), even as is.

Why not address the minor comments you got?

> It would be a real shame
> if all this work were put into this feature, just for it to rot on the
> mailing-list.
> 
> Kind regards,
> Max Brandtner

Reviewer's time is not less valuable.

-- 
MST


