Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F819CD4F21
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:37:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDW1-0000Tl-LB; Wed, 13 May 2026 13:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNDW0-0000TT-7q
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:37:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNDVy-0004ze-SQ
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:36:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778693817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMnec+/PTVtQzgIzWf9VTfYLvH5qz6Iu4SPk1cBOi1I=;
 b=KnXE9kRt4JlgSrKhyFNANVXUfU22Lt426F7cBQOEkA9jDzJLRqkKy7d5KzVT8ucow5momM
 Up2ZUtbmNB0C60Hw/exTfp1GeiHwuVZMH7vpIxs20rG1HFxoi+JTTiMHGwg/FWKKAmh1gi
 fTKdtjKtlsmoQuQ4TisIe7Wu/iLnxag=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-8amiIeQZMh27MKzrysstGA-1; Wed, 13 May 2026 13:36:56 -0400
X-MC-Unique: 8amiIeQZMh27MKzrysstGA-1
X-Mimecast-MFC-AGG-ID: 8amiIeQZMh27MKzrysstGA_1778693816
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b597b14a22so107167866d6.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778693816; x=1779298616; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eMnec+/PTVtQzgIzWf9VTfYLvH5qz6Iu4SPk1cBOi1I=;
 b=aDiXwzqE8fTfw/mZ2YvHjdAm3ecgSiD2sszV+aX+B17K2eK0Ru+5FPIC65Q2ko6OX6
 6MdTsGX5fxgqZKRsd+MIpWnkKjuKXVD01bfwvttPxMkzzCcvrr9KqdzAaEaH5a0uKpMM
 jFUtCpieB0g8cj/XTqgm1cPiCef0mjQnhb78i0lv1ZyvAikud8rECDunNvTLDoG8XNJl
 degt2xlDysRGWdFQwjuMk/+QfPvvdXa4u0lJXe0p1W4RlAxg7l4keIKFSKQ+BBnGLmhw
 jr0xh2O5l1VxNh+JKMDJemUubuAtRj/h+MmT2H2tlPxh2H6YvyVzxsQJKebSiy2wO9zm
 jlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693816; x=1779298616;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMnec+/PTVtQzgIzWf9VTfYLvH5qz6Iu4SPk1cBOi1I=;
 b=AqSKwRQYHGnzNxNzTbhBipXvs3ATCigobrTlVz/sx4Vb4Trn0lwSr7LJ4E0ZLfJ23O
 d4ZOgHBdBn1XdZllEELmhiRpmsiimXUZj0+TlggCZZzGm/zBhb3O/Q4IZ22FLbsyo+ul
 mwcE5V9VUjbPo2lkFTWbDlVmVTs5MZpC2Qs9VRDiLHB0DbiS0MHV50PeHIekMUv8z985
 BBgFhwJVnOxdgrXMyDOatSeql2viaSrAdYldgNuR/oSzgQSEuDiZEibqhjx0ZXcs4oJN
 ZvWHlYQ6IOpJtI8R8zjRsGRtnp4kmSNouFRbZ7vKm9FO3QVP/uyXA1HYcvN37i6E5UCS
 kTQg==
X-Gm-Message-State: AOJu0Yx2maalxhwmLfeK+GqTpZQcSXAulLPR0Y+h2PSnaG6nMCxxlaLe
 V8vPLhlDFwyo+HoW+ma1lTC6JTFTvsaJCMlLLseEcAw4feTcMMdpF3pvMCLNFfuM4LWSJ3qI+MW
 7XdWKiVfMX0S68oY1LCDjKOCAxZdz9+x2XjhIHfK2TrRD4x61/33voqxv
X-Gm-Gg: Acq92OGm4G62XfsJPjkVtvIBJdxGtHmhAyZHObhWU6n6Qt82zHzXsjZ+lkCrcZqUogx
 Qh9nSiKGtKexDZ1V3jwUv7ktLtc/aZOy5rLoj0wrUFXTgxL90+/M2YR07MLP+vwHj9+od8DVXQ5
 kgNfxvO3/fPR3nxnbvQNLbxnUxZAfHW2bONBdD0r0NU0XQudMjdfZ40r+P0HiPZtHL47+i29l6e
 X++QjhzlSPFryI9TKeRDT31AD5QuWNYhyVNMqDxObm5HcVXt7J6oO15144ZGSH530aeG/0YQFZn
 s8qvaTd7l0/CEjGZZWHzkZQ4ZSOfwRG6eGI5sB1rgSZfiEQ01nC6zHUSTO5UjSlW5+N0BiY4MHE
 OaZ0v8UtRDT5fSj4eE04Kt36d6MceH3L/+SmPPqV3Uv3Uo08=
X-Received: by 2002:a0c:f005:0:b0:8ac:ac91:f421 with SMTP id
 6a1803df08f44-8c8fa0e676cmr6373026d6.1.1778693815808; 
 Wed, 13 May 2026 10:36:55 -0700 (PDT)
X-Received: by 2002:a0c:f005:0:b0:8ac:ac91:f421 with SMTP id
 6a1803df08f44-8c8fa0e676cmr6372626d6.1.1778693815176; 
 Wed, 13 May 2026 10:36:55 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8c90b2dc41fsm1583976d6.25.2026.05.13.10.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:36:54 -0700 (PDT)
Date: Wed, 13 May 2026 13:36:53 -0400
From: Peter Xu <peterx@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de
Subject: Re: [PATCH v2] migration: Replace current_migration with
 migrate_get_current()
Message-ID: <agS2tdTFINZHVUdx@x1.local>
References: <20260513063513.250911-1-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260513063513.250911-1-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 13, 2026 at 12:05:13PM +0530, Aadeshveer Singh wrote:
> Replaces the direct accesses to global variable `current_migration`
> with `migrate_get_current()` to ensure consistency across systems.
> 
> Note: Following this only direct access to `current_migration` will be
> * `migrate_get_current()` itself
> * `migration_object_init()` initializes `current_migration`
> * `migration_shutdown()` to pair up with initialization
> * `migration_is_running()`, as there might be a case where this function
>   is called by a thread before object initialization
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>

queued, thanks.

-- 
Peter Xu


