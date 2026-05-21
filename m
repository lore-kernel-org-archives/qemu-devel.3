Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9848CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:47:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3kS-0007Bi-Ac; Thu, 21 May 2026 09:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3kE-0006vF-8e
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:47:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3kB-0002dL-2G
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371242;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8TEJxnfV5vd+BoURyhPm3NVl9yBTSRiCIgEdiyBq0ug=;
 b=PSMM7lD89sIF1L3FumU69aBP3H4jdpEHOSYEq4+Gu6mI1dRNdbjq4guUl6qwTvmg7IqxEi
 k6yqlLlFzEtbu3EGMEC2F2vG4NqVmSX1M4/GJ5HFBtFwtP0JIaDDeTzaXxdjll/9qT4thU
 YQG+EWBKFl6OReNK4nyW7g9Zglpb3WU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-_fTF8GZSNNSIo86ARtRBrQ-1; Thu, 21 May 2026 09:47:19 -0400
X-MC-Unique: _fTF8GZSNNSIo86ARtRBrQ-1
X-Mimecast-MFC-AGG-ID: _fTF8GZSNNSIo86ARtRBrQ_1779371239
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so862257f8f.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779371239; x=1779976039; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=8TEJxnfV5vd+BoURyhPm3NVl9yBTSRiCIgEdiyBq0ug=;
 b=C9z5gADnaexVVdrjNZ/c9316xY63XfUXkwVFDHc0/NF33U3D/I0FJC+G+378UrxKbX
 EIx6XFIZVD3yapxNZaxX9FbO/R7542ltSTjJmyXUWskQeUUPQ4ue2RspIhkXyaKZuQGc
 TqfUFQm0x9gkpj80dtVpxBlvtsdcHdL6lwe3aHjzDyLRqROtg4W6qVbgMfvgvrH5Ue59
 eAj8d4HA+TzftN7GutE+v6IqOUOMvZZPQnPewMvzYvT/zF/aREP3wmdWm7vhULTZqNnM
 kDiwMsil2yP/AHV0tcAivFuTWxANOtxK3/5p5pXCnnzCLDx6/vfY9kyhhN/n/RvRQbDc
 DXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371239; x=1779976039;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8TEJxnfV5vd+BoURyhPm3NVl9yBTSRiCIgEdiyBq0ug=;
 b=GYsI7GqS6iXEX04PHUVKkXy7RLoStQe0IE+IdsMqoB+v4mA7za6M/RjHyLTvW6IJPa
 wZNbWmR8k3Irq28lSu+wKblKw7PgP+L7GoMurb+31lxW9HXy7bh/ukPdjcqDeyNMDrC+
 torovM9/dqVvu6ZF/VKBRorPkVrt78XaVOj35+jZ0NCuMierpuy+pQd5XMpu3cKO7Z1+
 agZwiNT3ZdwTtdv8BkuT0LpaLQi8cG8Mo8m/4PoN+KPvCOL4DpHt0poIcGzDK/QjxDzE
 9+2m/QNCerqY95nKycKpGKBAHSIrpsBx4ZveZjipYNdEIL933TjF1fXh1L+PK5NUfg5o
 avSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+CvjYLa/ZfgOc65wOBPwgiZSR6Zri8CRzjTnS6UNL14u+/LGy4Kc/n1/yWJSH73EobW5QkwGMj7xEr@nongnu.org
X-Gm-Message-State: AOJu0Yzb6a1jZeFV/VENjr3UIwe2MfjtPDRPShW+o+a3jodVkeTQIix1
 rHOQ+IyRhMuEbB9DB18kq1TrYvVAUgmXJS1MFmU+AOxbV/PMQ0iT0uIWa/mEqxUl38kaSvL083P
 3X/u91Adx8TKwnX9jrRiRxys7nIeQEcBX6XryPiz/TRlpjZgmtHj1ATEi
X-Gm-Gg: Acq92OGxf7bKU/t+RfOSVVEMhiHy82+7/FIdJSQTBrVGwIhzorAbYJmlJN6JMMPwwvA
 iCOiHTUGLMFimeE7mNtYk/O1g8br0u0fKnhTFYgfmfjC0u1UaqDnjQUKXljpae84cbdn0/kkWeZ
 wJ7zvii61prrQh7FnosK1guCklF4zRxuAyHok7goWtftwd+ajgqinUbXApUxSxUxyEeKpOrOTqL
 SiJPROqcsV3k1gZ2G4ZNXotXOVOcUTD9iQg0OYyjMtWRpzPOx3nbBFY6GWxDw8e8kZ+of8FS7RX
 dAHLX+KGWbO6OmxMWgehRQLdv0mv7DhYWcjhZHC3Dou0tXBjm52gCs4jq2mosLdSfc4dR3B6IJI
 nb6lCotRDdiP5XpSBWfs4uOEUeFGoOVo/M9E/S/ii5IxDY4t/Lc5IPa0TWFF1FFD7aCauul8=
X-Received: by 2002:a5d:5f91:0:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-45ea40f36ddmr4620348f8f.35.1779371238658; 
 Thu, 21 May 2026 06:47:18 -0700 (PDT)
X-Received: by 2002:a5d:5f91:0:b0:45e:73b4:85cc with SMTP id
 ffacd0b85a97d-45ea40f36ddmr4620285f8f.35.1779371238237; 
 Thu, 21 May 2026 06:47:18 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7cd815sm4410866f8f.6.2026.05.21.06.47.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:47:17 -0700 (PDT)
Date: Thu, 21 May 2026 15:47:16 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 10/18] target/arm/cpu64: Retrieve writable ID reg map
 in aarch64_host_initfn()
In-Reply-To: <20260519132905.145643-11-eric.auger@redhat.com>
Message-ID: <23dd2f71-d5d8-952e-c32c-cfb3537f89c0@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-11-eric.auger@redhat.com>
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

On Tue, 19 May 2026, Eric Auger wrote:

> Store the writable_map array in the CPU state and populate it
> in aarch64_host_initfn(). In case the retrieval fails we simply
> free and null the pointer: this will indicate that the writable_map
> is not usable in subsequent patches.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


