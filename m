Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187E0D10F58
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 16:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOIOg-0006lJ-7S; Wed, 26 Nov 2025 11:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIOf-0006jF-0Q
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vOIOd-0005aZ-Ic
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 11:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764174575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hWcxZlvjjD0z1Ag5RJX1c6gU55Egabutbxi2aRboQGY=;
 b=bqItfNYZ95SPL7ObmIxbAmDMDPlar2esTxNiVlySI0fdWFeqOk+CSfIKLbFSlWadQWvQ4A
 TC6swvtpR+9gqHOxREPK1FUtLVGu5mgrZvGCjMBBZOR6mjt3IBC3MgAw3xyh5IktqGJE1b
 gZ+eE1RUxo6qg+pu4Vk8Qb+wzKJ/CX8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-ib76xK9lMLKkuD5FKZUbFA-1; Wed, 26 Nov 2025 11:29:33 -0500
X-MC-Unique: ib76xK9lMLKkuD5FKZUbFA-1
X-Mimecast-MFC-AGG-ID: ib76xK9lMLKkuD5FKZUbFA_1764174572
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so37278375e9.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 08:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764174572; x=1764779372; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hWcxZlvjjD0z1Ag5RJX1c6gU55Egabutbxi2aRboQGY=;
 b=nStXMsV23ewyY5lrjzkZe/AJd5hTVHxw8uuWdl1pIBoUVi06uC5L4001hNn9defWeG
 HRXXRZvw6xgrCqO//1p1+n9yAJcb+O1Z+IfyMdRZqfEM6fTJzMRbv9H/wLH3XSYEOwgg
 BftYa4CBlkzzaE0ufFU+y+I+W3eXGHUQpVlqWhMxcXt1dzPinXMKcSS1IO5932Ds+c48
 1F6YiEs3cXhaP55IwCaWAnZm9Ll9evFAv92wsaxtpiZE6cqGLoXwkRI4bJrHkcQ7UhaG
 tZRAPrXPERGiOBHce2qftj2a2rqtgF6GZ+vLm1EyfAGHZx9YpzQv4TCjTcUqRFo8roGs
 q3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764174572; x=1764779372;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hWcxZlvjjD0z1Ag5RJX1c6gU55Egabutbxi2aRboQGY=;
 b=ItMzDCol6ZGSV1vkjgVLU3klBHoqorYh3Qw4dnY5pxxdzz22sOZcVEKZ0C7xsg5pLf
 eOvk3VtnizV6f5fe2Ph6F6koJo24f2NJZyH6LbvDERMfJtHf7W3JqJ0bVY+kuqyQpjSB
 h9GxEftF4rNfdhR8Dhz2b+Pe2DIiwwok66auWrM2E+yZXx5exRadnkTwV76IuXPQVkBa
 +0kuc59bpgRZcR6G5W5JcESXoF61+7837Ie6G1Z9BMEL7kojWVhY5tfkDMgDhEcpypOL
 UuHjNiKXZ05YOF86f7iLAl5No5wOfn2Myp/+3QJi8KvoRYkUlIZd6Wtj4ZGQ0BBtRTF7
 Jrfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMG5b5Q9bbp/m7Pz/yEQcImnSyqXIAgc8chWzQgvTrTFF1vQ1e1i8MsQshi98j2bf9KR6L5TU3aUWr@nongnu.org
X-Gm-Message-State: AOJu0YwRxxVaSkUVOyOdm4Ahh1ydgUNJGIVUQHCdJRJQ/mBSrRl0t/4t
 RciNWE4iTmQ2dv8xc0rHd3DTyhyVy4L0gFRKZhINorcv8l964JqciPux0vz5mGnKFdz4FgAvtWL
 RqgxZBifVDAeDakmP6/cAazKUH68xjb/2BbajkaufLeltzwqseGeOxEp6
X-Gm-Gg: ASbGncuDZMF4xOe7FudsDgJdODNdFCERrA6zsEH9tg7rRq70rHx4dhstWjLknAShdtF
 5wnILEt2lSGMxtcA/kwX6fMN46c8OCYI3Dxc15/RSKFdyCsk7mw4oFxSD4reSw5kMzFEwQk0XY2
 R1t6CbF48ZsWVRs2WipaFmZ5wfvcQWJufDHvh0iyCKOdd8K1kXvfXPLNgmLT1UAHYx9O3RR0oQK
 tnR65QhNNO6fuKnJ0bTa9MsY5B2LYb8za78KMdnKROY4zcuJ04CutsIr2inGPBrrL9fl1Jt1qql
 /VhL3nI/pWdpb2QQJ1gMNfN70oqeIx204zL6eAijRMTZAWXNuzpAXEraDobQOiOyChp82fHvcsV
 w2jxpxHQv28BnVWcbJliktwAsYFqfoKHPXvle1tXhPilhxUdzDX1C6nzodA==
X-Received: by 2002:a05:600c:4694:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-47904ad06f3mr70148045e9.11.1764174572043; 
 Wed, 26 Nov 2025 08:29:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHdJO78nrqxp+K03Ey3F8Uregtf1SH4+s/E4pFl24ODFF4QhUNka3V0lANpPBILLmwGcPAr3A==
X-Received: by 2002:a05:600c:4694:b0:46e:4246:c90d with SMTP id
 5b1f17b1804b1-47904ad06f3mr70147755e9.11.1764174571698; 
 Wed, 26 Nov 2025 08:29:31 -0800 (PST)
Received: from rh (p200300f6af35a800883b071bf1f3e4b6.dip0.t-ipconnect.de.
 [2003:f6:af35:a800:883b:71b:f1f3:e4b6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4790adc6220sm54029395e9.2.2025.11.26.08.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 08:29:31 -0800 (PST)
Date: Wed, 26 Nov 2025 17:29:30 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 peter.maydell@linaro.org, cohuck@redhat.com, maz@kernel.org, 
 oliver.upton@linux.dev, gshan@redhat.com, ddutile@redhat.com, 
 peterx@redhat.com, philmd@linaro.org, pbonzini@redhat.com
Subject: Re: [PATCH v3 01/11] hw/arm/virt: Rename arm_virtio_compat into
 arm_virt_compat_defaults
In-Reply-To: <20251125100859.506228-2-eric.auger@redhat.com>
Message-ID: <f0a96d9b-3a35-e6a5-ed68-9de886623ffd@redhat.com>
References: <20251125100859.506228-1-eric.auger@redhat.com>
 <20251125100859.506228-2-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 25 Nov 2025, Eric Auger wrote:
> Renaming arm_virtio_compat into arm_virt_compat_defaults
> makes more obvious that those compats apply to all machine
> types by default, if not overriden for specific ones. This also
> matches the terminology used for pc-q35.
>
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

Reviewed-by: Sebastian Ott <sebott@redhat.com>


