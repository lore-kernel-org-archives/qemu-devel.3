Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C91F5A8B6
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEukw-00075Z-4v; Mon, 20 Apr 2026 15:58:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEukt-00075R-IB
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:58:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEuks-0000F7-81
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776715080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6LEuJrRCyRLrRNrDolQSQM9HgiZhjIAZ2005yhE8W/8=;
 b=NQivlnReopQEncPB2k5tzqTI/Xw4/QkKy3Tb1GCUkzmWprqSRvcvXcP2yxq/FKaJRO1vCY
 Nt9PfAB41mNVK9UewJwLa8DlUZ86/SRbleZPVJj/VcGcAW7I7ZV3JA7oCA2iQ1tp34orzb
 1MzoFaJTpt/7Ejs17oKcBmG5GcreglE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-e4VS1E4nOBGUArdHMXXdlA-1; Mon, 20 Apr 2026 15:57:59 -0400
X-MC-Unique: e4VS1E4nOBGUArdHMXXdlA-1
X-Mimecast-MFC-AGG-ID: e4VS1E4nOBGUArdHMXXdlA_1776715078
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8ead5ab474bso258340885a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776715078; x=1777319878; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6LEuJrRCyRLrRNrDolQSQM9HgiZhjIAZ2005yhE8W/8=;
 b=b2+XJkZDNwyl+0Z7qpFaJ+Podx6OcFWpCBfA1zYS5VxTqxvAe9WkrJoNU43h5g9J+8
 O81M8eMQmNalGu5fJCwCgX8rx9p1OHenwwTe0qVSByig09InyDtuuu7NEmZEdGL4Rivq
 ebHfRSyRYnltQjzEGQ2/GU+oStU/Y0jbjng+boodwgANxYAhl0kVA64Vvz1YxJSdq/pq
 5uzsvBZPDHHoxLKNknmXT+MQa6pcYEwu1Ow/5vyJjUeOSl3Efzn3XBjrSpKGPzbpjrOX
 a38GEOPHAHXX5dkA7vEDVgICtgdQ5CQTBTRG6y9Si2mmswk5eHW4dF/Sf+e5uysJaIYs
 nkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776715078; x=1777319878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6LEuJrRCyRLrRNrDolQSQM9HgiZhjIAZ2005yhE8W/8=;
 b=DGefTR3oe70tpaqaiN12KW2W0iOIRtSuGtvNhCmYWy52MwhzciP+pXIIQu4FhQhY60
 CYrQfaRUsb/UbmOF74jEUXtx6iFMzm0F5j9qU6A9Gg1NsXgNVynzjRWtbUdxzo/PbBRI
 DVTrZJNYSxbBsuk8wqBSylXqfz6AiySO16JBhwWSMsK2s8pRI0DA/dI/n3LXToI2USJx
 iyJXUtApUWMmdfazmYjALndPL8zrT032yWQSlBVqbb+wsXkGmjhRugunsSYo6zMGyKja
 Ec0nGDpGgRQ0exvrUjXgY/mOs8Bp2XUizBhfNyBBSvhryxW5VZ5gOH5DF86YncgZjDrW
 KWiw==
X-Gm-Message-State: AOJu0YyDqVX9RraiisGETXwlPIEs9RE/SiwwLTwkmOqMPiR5Fa1+Cjl1
 e5/NtcWZoEZ1JSc20bzREKyZu0f5spco0gLsTZxep0HVie8SjieKFFEAchI36W/izlNGpu2D8A9
 WnML+BqVGuD/NBejNh3lSbR7REtqNaqbt/3KBnTUemxENAqLLHy9DnqsJ
X-Gm-Gg: AeBDietYjHLFkvxrDdARnWyMHhoRd8Co1F+9fsoLzp7co9ZSzcRG31XduQ9/KHHCXst
 e6mSbOxpGthuEYrv7TujH6LzVxd39pxwBFOjHO3ITdhNuuBmbO8eDvByTmPqtYwLbY/0fyMAuMn
 CVDMsCXG4eUeNDnyX7SDRVe/OezfTzPcwrGInL5zbLGFstlZOujob4J/wbr5oqDMeYmzTmUxDCp
 zEqFSgpH4txpDpIHuWWskIiGWvrX8/NynvuCJo8Rnw3npwdVZe/USTpLbvqO0tdnzHZ1rEtLng6
 p8Sag6jmhFy7sSwQUkREtsc1+1aCSoFHArrGy7Kl0sHt9ENgA5Qto2Kr6v03hKIc/95EQLO3Ryr
 NFN32/vFB0//7TiBqTnsCnngXsdRt15vZZAEFhUYDh7Kui+AuuwoAFuReKQ==
X-Received: by 2002:a05:620a:4502:b0:8cd:8785:eff4 with SMTP id
 af79cd13be357-8e78fe208c1mr2358026285a.15.1776715078445; 
 Mon, 20 Apr 2026 12:57:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4502:b0:8cd:8785:eff4 with SMTP id
 af79cd13be357-8e78fe208c1mr2358019685a.15.1776715077639; 
 Mon, 20 Apr 2026 12:57:57 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d64caf37sm865965185a.11.2026.04.20.12.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 12:57:57 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:57:56 -0400
From: Peter Xu <peterx@redhat.com>
To: Trieu Huynh <vikingtc4@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest/migration: fix fd leak in ufd_version_check
Message-ID: <aeaFRFbJ3uInmVKE@x1.local>
References: <20260419110304.8661-1-viking4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260419110304.8661-1-viking4@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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

On Sun, Apr 19, 2026 at 06:03:04PM +0700, Trieu Huynh wrote:
> From: Trieu Huynh <vikingtc4@gmail.com>
> 
> ufd_version_check() opens a userfaultfd via uffd_open() but never closes
> it on any path where the open succeeded: the UFFDIO_API failure path,
> the missing-ioctls path, and the success path all returned without
> calling close(ufd).
> 
> Convert to a goto-out pattern consistent with uffd_open() used in
> util/userfaultfd.c and migration/postcopy-ram.c, ensuring the fd is
> always closed before returning.
> 
> Signed-off-by: Trieu Huynh <vikingtc4@gmail.com>

Thanks,

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


