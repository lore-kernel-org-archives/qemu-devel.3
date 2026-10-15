Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3B1CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHGIU-00013m-0Z; Thu, 15 Oct 2026 03:54:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xHGIT-00013d-6r
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:54:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xHGIR-0004R1-OR
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 03:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792050878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
 b=VJE07XKD+U+ZbBqm91GQ3ZN/aEy6yEMeabRNSWu+Jde2WUCcyNMNuoc60CQdQZrqPLixXB
 1hcZ2pbBTaztFhess9XIS3CWVyI3zByb1w4v30lv/xNQPstHaFJKLgWMYImPUYW5E8CyOs
 pvJMFD+kpRqLK0HTPV1J6tqEv54uEqs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-iSNxzwgXPgqrislePgVtVg-1; Thu, 15 Oct 2026 07:54:37 +0000
X-MC-Unique: iSNxzwgXPgqrislePgVtVg-1
X-Mimecast-MFC-AGG-ID: iSNxzwgXPgqrislePgVtVg_1792050876
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a17e77c5b1so14906525e9.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 00:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792050876; x=1792655676; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
 b=rCdkoH9hwLkR8jzIKzBIEFTwkBlhVhsmX+waailUAVjNAmqpfEEVtcjLkXf3noVcy/
 FNUKhaHd0XmFTcoDkBI2T+TofTYvIQMNhAtWCNllzi6sF7seumahsJlMdO9xYolT2sWq
 +Gm1gu+6Lw3L5n5n9ReiSwy4fGeCRzUw9hC8i2+iCjdLGZ7LF2TkrVTYIqU3HlWz6/lM
 AjVIZnekmxlGmHE2f9ezYsFE26Z7Ow9NZAMewN+L05MNdsJhp7YRkwe2w1WB3z+I/8QK
 q6JLyEiHBAf+HabI/xz3qyhv3ltMxUlzRCFNFyVwraYJypWC37H6nyqFVnXFRm9P+kQL
 48Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792050876; x=1792655676;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l6twZoHnabfZa9E7zwB119jg5IyCAwxBQB9uv9orm0o=;
 b=qe+lWBffsIRw7Zx6jU8nf66rt6TjJrq0mzfn9YR1wWS5mrnarLpnHU+E10vOA+vIFH
 33Uiutgbd9teG9yYk6oGjoop3vQ4QCXtj+H7Yx0H19vuDW7EViSPl6PUfPbc+dEYVDXh
 mEEQvAbuyHky2Ds9cGVBJAzBBOncDPs5H1fuyNhTvhifikzBcKnTPqhDKPrV7ulNFOlg
 JKkQksKy/L7mXrG0MAf04K9tl3tWnGhk4mScjs32BDD2vyvjbv3GsyW+rv5r89ZXO6+X
 XX2A69oX0CnZnzZxWu7AaxQk2YZHxKpzhjI9uh2JQzHedGV2wIuOx8kYpPr9qBQqTkfT
 UDFA==
X-Gm-Message-State: AFq9FYJV9SABbhS8inVQGGwBmQHMW8e1EW4fJjP39YnXRMymD5Wh644t
 BaCY6vR0Tk/s+iAXbK8zswiMjgkjIQuptkSIRpFlvSywO1PbntdKHtWnBe45vLeXpziTQPGXHNy
 ods3yIieIu+PhYlgCZz4imD0UXEbdW1O6eJf9/pru3RmkPnNZEs3fZQHr
X-Gm-Gg: AYBFou2G19lCOF5rNUkuPjOzYZJIYiaoU76doD5489v+V+jyuETWu6neQP1LHJ6ESd+
 DirCG9K3PfLBculpaQd+ppDNhhkZS7PTzDvGv6hUub8xWJviukB6ntLAOX2NUzK8qXbitb9tbqu
 z00IsDXeSCaTSb4vBYqWwJ6TuAkDVzyI7whGFPGxXkreT4PvyvQfRQUcgpGPnGWXXnPS34vvCLL
 53lUF1VVsV5n3Ql1MasfXmYkGo5vGxeuVJ7IIb9Kht4bleuYIKmc/YwesmXwyz4F6FbZtuZtlCQ
 hrLs80/VEIPogcRcvFMLlDc/G+wVrCauHo0TFc+v2W3FG1Hlg/vQirbInXqb1ekBqU1c9CBWUeD
 kXlIl2n9WURWWbjYNFPWjzUg340MZ5fK8oj4=
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id
 5b1f17b1804b1-4a18e4835e7mr319120185e9.13.1792050875917; 
 Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
X-Received: by 2002:a05:600c:3d96:b0:4a1:746e:5898 with SMTP id
 5b1f17b1804b1-4a18e4835e7mr319119865e9.13.1792050875579; 
 Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
Received: from leonardi-redhat ([176.206.38.69])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdbace19sm52653635e9.14.2026.10.15.00.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 00:54:35 -0700 (PDT)
Date: Thu, 15 Oct 2026 09:54:33 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org
Subject: Re: [PATCH v2 0/5] igvm/sev: apply the IGVM guest policy before launch
Message-ID: <atCGn10gISek2sZE@leonardi-redhat>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
 <as-gUPOHujXsPiWV@leonardi-redhat>
 <atCFVaKiSIvz9uVS@nucbdw.ghoffman.csb.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <atCFVaKiSIvz9uVS@nucbdw.ghoffman.csb.home.kraxel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Hi,

On Thu, Oct 15, 2026 at 09:50:32AM +0200, Gerd Hoffmann wrote:
>  Hi,
>
>> gentle ping :)
>
>Any update for the igvm command line patch which needs a doc update?
>My plan is to bundle them all in one PR.
>

will send a v2 later today!

Thanks!

Luigi


