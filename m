Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30635F5A8B1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 19:50:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEudL-00055W-HY; Mon, 20 Apr 2026 15:50:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEudJ-00055L-0L
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wEudH-00076e-Gb
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 15:50:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776714609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MeyCP5I3ANLkTPygS9lmtfdAhalPzkFNY+mh3e/KtkA=;
 b=dJqsyigzkcLYj2ENUUqc8RHz9LpESPSC8c/QaFXa/G2CO1Hp4qe+ufjxKUU9DfjRj9/vI7
 lUZF2MnmQpwq0XQBxVWp3Nnco62vCFVrtHb2xIoPtFROksml6BU7sC6EPa4q7QPcatZkDx
 RLbFWYOkyIv5MKK3KdVyOHldza3NGaU=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-RccKscmfN2-UX13g1METyw-1; Mon, 20 Apr 2026 15:50:07 -0400
X-MC-Unique: RccKscmfN2-UX13g1METyw-1
X-Mimecast-MFC-AGG-ID: RccKscmfN2-UX13g1METyw_1776714607
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a22dbeeb96so65762106d6.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 12:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776714607; x=1777319407; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MeyCP5I3ANLkTPygS9lmtfdAhalPzkFNY+mh3e/KtkA=;
 b=qXR7mlGvan2n8iWC9dJrf2+vSrNr31Qr2W6ou074fqqjrcro9YWCqpVLMNj295t5qB
 Xi2/aqIwzXNemvBgUufPzdMAHUA3fIJ78u91xUYrjllz9heeGW5Tn5VfCERP5P4GrT46
 bnJGNbmzwn82U+HaTkraR9vGMu7oaCpTk5w9gibGj6LwVeP9QPmV+KDrYNk1MGVQAxYO
 JHcWsstEAfFcZ6o+vVUDExJoucn3UxrJ60Ina4cyWulhkC4pPb0x7UUX5LhvHI+KO6sj
 ATP51WlgeM81mm0xiTP3Dr1jUfpMAj5J3yPxSwe8j9XvNBa7txZdcfgBgEb4kni8gFvI
 LYew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776714607; x=1777319407;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MeyCP5I3ANLkTPygS9lmtfdAhalPzkFNY+mh3e/KtkA=;
 b=lBqwLgzeDAuplWC1RZe7jVTymu+o+LsofjKFEGJ/V40osvY83Fe5VIO9MjVLpbAZfx
 65b/o/m0mIl7ifNifVjosyxQ+1faa/cEnQHaqOQMd+rOqqYJREOqh+kJM0vdj6FOX8bA
 jl2vG1d/Ach7Xoe4A5cTqU07z7njwFsbO/2fgUtl3BENy3V3/kj64UZGHoIOPFRR00mx
 /wvL98h08DbpQhaCZoNfqD1pUxsnqfPZqMAHvozjyCwL656ppQzkXzDcjLiZG7PFUkaw
 I4TOAf3WhMAjr/5mrTj+KSxblLLskXjgFMRVqpiJ1N7eNIOcq2VGP0JBONksKiln0USM
 8VLg==
X-Gm-Message-State: AOJu0Yydg8uKK67x7RKM4x3qGa+W02wTTYDcCXYtA8zKfrHG1JVWSby9
 Ql0z6kpF8g7jyKcXGCJIAus0Ddzkcs5Enl5OccMHDtOf2CEsnAmCX74coOuYWNliWTJAsWAtfkl
 iuQJSKgHiSogYh/Wd3EzSUdg9W7oKF4QA5VKn26PAsXfQFiiVQufMScTv
X-Gm-Gg: AeBDieuu+f+DvvtPOs/j2XANaE6BFcDo9kDo7eeGHjCJgR+1r7RH9iWf4rv6LgfVoSr
 QAHR8w2+Ljo+UWmloXdzqRTJXnsHIsTARGKYgjMv73GQGFlswrD/ta2jc5h4iQJQFO5mXLJOXjo
 Z4+TSLyFm3lJ2F74XLhWwZIn/0LU/ExmEJc075FiZYEYkaz+RAMtYPjIdiSQldCDAwmQ/cNn13k
 PnO6FfE3gxDkcYbxsNF7ID6HQfvzbcyKOycbDCJuqWJQabVxfnZZhEIO0JQXr25B54Lf4DroJ7m
 pZqAjEy2kEwsQqT4/fFchPLLb3CMa7w9mtp1wjbve93EHh+mWYbNvZdR55RtwygBOA0K+2CDyeP
 0jHKOqfyi6aeC2vS+qaV83/DjM3ml5/5paGDF8mpemFFIhy/ngdEmEhgXsQ==
X-Received: by 2002:a05:6214:2686:b0:8ae:6460:c544 with SMTP id
 6a1803df08f44-8b0281fe7b3mr262542946d6.41.1776714607118; 
 Mon, 20 Apr 2026 12:50:07 -0700 (PDT)
X-Received: by 2002:a05:6214:2686:b0:8ae:6460:c544 with SMTP id
 6a1803df08f44-8b0281fe7b3mr262542086d6.41.1776714606465; 
 Mon, 20 Apr 2026 12:50:06 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ac4260bsm81606526d6.4.2026.04.20.12.50.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 12:50:06 -0700 (PDT)
Date: Mon, 20 Apr 2026 15:50:05 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH 01/11] vmstate: Pass in struct itself for
 VMSTATE_ARRAY_OF_POINTER
Message-ID: <aeaDbQzuCRA2QDNO@x1.local>
References: <20260401202844.673494-1-peterx@redhat.com>
 <20260401202844.673494-2-peterx@redhat.com>
 <871pg9fn7s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871pg9fn7s.fsf@suse.de>
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

On Mon, Apr 20, 2026 at 04:25:43PM -0300, Fabiano Rosas wrote:
> > diff --git a/roms/seabios-hppa b/roms/seabios-hppa
> > index cf3a472f4d..1a8ada1fb7 160000
> > --- a/roms/seabios-hppa
> > +++ b/roms/seabios-hppa
> > @@ -1 +1 @@
> > -Subproject commit cf3a472f4ddea30d2d483a8ba4b005505f0dabb3
> > +Subproject commit 1a8ada1fb70643172e251aacbac673c9ecda99e9
> 
> May I delete this hunk?

:-D

:-(

Yes..

-- 
Peter Xu


