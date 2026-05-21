Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B857CD4F3D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2026 13:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQ3gX-00050p-1L; Thu, 21 May 2026 09:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3gU-00050h-Qk
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:43:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wQ3gT-0000aO-Fn
 for qemu-devel@nongnu.org; Thu, 21 May 2026 09:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779371012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MGAqhEoCrxlhG7ghF4d4bubuWjp/PvPTdNOMZxG+QiI=;
 b=Kih9Ma9tL5r0/5+W/4w/GlM9oVMmyaW1U5rKjhTJx/GKcZdBTxSk6FcBea/DDzNYs4Ixll
 bwhLW8pbtnpbwad5ORzlKtvca7g6xIotydLoDyooiVZin9e/GbeR8QnPDyJfeqb8JlKMWz
 8dZ8+EWeFRfrZlMWB6AA3ltK9sxxUH0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-aevYaZkxOD6aA2awGT5aBw-1; Thu, 21 May 2026 09:43:15 -0400
X-MC-Unique: aevYaZkxOD6aA2awGT5aBw-1
X-Mimecast-MFC-AGG-ID: aevYaZkxOD6aA2awGT5aBw_1779370989
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fdca5c638so44539565e9.1
 for <qemu-devel@nongnu.org>; Thu, 21 May 2026 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779370988; x=1779975788; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=MGAqhEoCrxlhG7ghF4d4bubuWjp/PvPTdNOMZxG+QiI=;
 b=aD87A7S0igrHNvpsVYL+k4NmnfsXx928K0r2NJnw9mbJf7wFWTp1ADE+1EzyNaGv7g
 E3WCU4ozQIY+MLodNl7REThkUgyLrINYJZmyHxgnV+Ou8Dp+Ze1KItIepE0Vqvqi3kc+
 vMkbWgxJ4AobPusTh8KuWr7IDI4sAS0+Q42aRkh8lG3e9txOObHqSbsuACL1xfV8Emlm
 lE8YSO5hUPNgD2yZwoVs5NwVaVVc1wbwQr5o8/K2eF9TuuxoSvbcRcKffWZvRjOWePLu
 fNqILqCb0yLQfJ25esDf78OI1729W2aQOTaOD1Rf9RB+tIHl05itNNPnjPUQm+qJZ/AD
 nPnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779370988; x=1779975788;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MGAqhEoCrxlhG7ghF4d4bubuWjp/PvPTdNOMZxG+QiI=;
 b=hsS4LZBe921KCpAGABTTkgR8PWseKMxgskOwZLnzXKiojxswPTNZTqF2LCoZ1u/td1
 uYkYXKPvzCqfY2Ryt5wZjOvA51ZhDG10rPntNUPQkYnjhEzoZPI95QEfiZkLtSKUzlvQ
 a5xMy8DMM6y3kjTU8f1KkGiojWxImFt/BT/ojA/9zJic7mpxzgtMyD7GOS4WvOche/iQ
 tF8IDw4JBIbBnUrw8GiqqPtPeSKh6vsVNhvnSUO9jI+AWPdiK0EAOlk2eskf9Y/haDm5
 3J92yRtuJOzdcmUgXRB0Irmc7gqTEf1Jt8RxzTP16Or0tTDIXY0a7JM8a9nw4K1sOfJx
 Ug0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ9eTZst7Qdo7h8ZgtbP3xZTikOqwH6K3+ECCvjwEcLalMTPa/ffrrCNVsKCPwav5btFY+wKqmF8LyD0@nongnu.org
X-Gm-Message-State: AOJu0Yzd47a7yq0OEPq1frn4oJVuOB/GjtWEW42PjTnpG2ysXeT39+Ez
 BmLC0Wf55JdgSqSnDyHRCjsnBAnzgOv9rpwwellAMv2EHzfetWHF5Xjy0d8ZnIsleXsF/XxoYe8
 ksL9F0YXtv+9tVOdd/g7kiml5Ndi+5X4ZomfGGTb1umLJZfDMkw0D0V/J
X-Gm-Gg: Acq92OFAFa7MN6DoNTqsdD7IRtM0vO0JR+e2rvgcxY7wxXj7rAK9cbBgLcxlCk4pa0i
 HfXvqULZdxmHIn8IDPx9sUMXEWb3dxQ6yptGVcOxAjW5cDlFbu/wf40QXrMK9ptG8OF+JyGkZsH
 XL54FOz9K2Tag5E6HDXKh4EDZnH+xZlvoYSZYtzSroBqwAbXOKNo015e9E+bneuHs8gzJQAMvYy
 yit2HNe1K0C0WPsr8yF353ZFhN5UVi4a0LCN2pSRaXAfmcYg+CFUFxw7d7sKqwZr3/OdhNj8z5F
 PNp0KfnTTurlq0uGZ99iLjepuL+f9SkoA1Did4JZZw/YPLlIisaqESjcFyMYejP/IsEBm28F0bl
 i3PdFSMXIUL3tCCGqtYHqgFtg1/1/1B5f45BntkrDy0czDkvErCEndeEg6J4z5qJyygu7Hrw=
X-Received: by 2002:a05:600c:8b05:b0:48f:e230:c3f8 with SMTP id
 5b1f17b1804b1-490360cc5d7mr57949925e9.30.1779370988595; 
 Thu, 21 May 2026 06:43:08 -0700 (PDT)
X-Received: by 2002:a05:600c:8b05:b0:48f:e230:c3f8 with SMTP id
 5b1f17b1804b1-490360cc5d7mr57949245e9.30.1779370988239; 
 Thu, 21 May 2026 06:43:08 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035c219a0sm17063105e9.5.2026.05.21.06.43.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:43:07 -0700 (PDT)
Date: Thu, 21 May 2026 15:43:05 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 kvmarm@lists.linux.dev, peter.maydell@linaro.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org, 
 skolothumtho@nvidia.com, philmd@linaro.org, maz@kernel.org, 
 oliver.upton@linux.dev, pbonzini@redhat.com, armbru@redhat.com, 
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Subject: Re: [PATCH v5 09/18] target/arm/kvm: Introduce
 kvm_get_writable_id_regs
In-Reply-To: <20260519132905.145643-10-eric.auger@redhat.com>
Message-ID: <f37a332e-1c0a-1017-f7f9-4df8a92459eb@redhat.com>
References: <20260519132905.145643-1-eric.auger@redhat.com>
 <20260519132905.145643-10-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> From: Cornelia Huck <cohuck@redhat.com>
>
> Add an helper to retrieve the writable id reg bitmask.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
[...]
> +int kvm_arm_get_writable_id_regs(uint64_t *idregmap)
> +{
> +    int cap_writable_id_regs;
> +    struct reg_mask_range range = {
> +        .range = 0, /* up to now only a single range is supported */

.range = KVM_ARM_FEATURE_ID_RANGE,
.reserved = {0},

Reviewed-by: Sebastian Ott <sebott@redhat.com>


