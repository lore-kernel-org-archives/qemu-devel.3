Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A850C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 12:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4dsw-0008DY-Sl; Thu, 10 Sep 2026 08:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4dsv-0008DQ-KX
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:28:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x4dsu-0000QW-34
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 08:28:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789043286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RlF9kn+HyNUEyx3z6d/XHzzDdZuEjKJCbcnRpLip9jM=;
 b=i+2CQyBtrPLAbWPQqj4IysQ81wMUpRrEKH260+VbDSyP+ShmFgMxzKeDO0FtP16U+mSReP
 R5cHeO6o4BYupk3aNIxSnpjfa/yu1epSaHeIWAJmguGeZODJRlwd9AsSaBpYNbQ2iIw7BI
 bxZmdHW0c8AiSyQxoMnLL0Ngd5ZTaik=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-XZDjqqfXM1-egmy6O4hNtw-1; Thu, 10 Sep 2026 08:28:05 -0400
X-MC-Unique: XZDjqqfXM1-egmy6O4hNtw-1
X-Mimecast-MFC-AGG-ID: XZDjqqfXM1-egmy6O4hNtw_1789043285
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9394ad7f64aso1094835285a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 05:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789043285; x=1789648085; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RlF9kn+HyNUEyx3z6d/XHzzDdZuEjKJCbcnRpLip9jM=;
 b=SIEJ+cgMsIyrkiuTtLBiBzx9+svJz8YdkOHIO1VfMEy6iEtcGlz+rwfHBSmVYNvsMR
 qe3xwyJqhI3Axbdk3HH/710JEqkpTdAS4GTfsjeeKOOcCg0AobMTF7XNY/yOgP+LdUvI
 TPZgq68JDfqlTYlK0GWxuRy7cvsDuG5pxCftre7U6rLx0ZUzM08fDSUkb9CQ2NLivt74
 sgN7Qm4ywYIf+X3OPAvDKHsdu9Lp0LIm+x2OP8RIpnkaoTJYIDuZrdjnrGF/NFAJwd1O
 SDdC7kHNGJnmEarTyEDXyab4qlh3Bij5nNk2xAS/mnAZyczAGaQcR/2JwsPOqyUOzoAO
 t+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789043285; x=1789648085;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RlF9kn+HyNUEyx3z6d/XHzzDdZuEjKJCbcnRpLip9jM=;
 b=A6F/AohZ3LxmZonqdB2qDdXPNVKWRyeKMPfMhZj1WO2LYPkcaPCFT6aFRsD1PwbsfX
 3hfWDR7x42EJdDZjVlLjuupcjQNgpnKcs3IiShp6N0YsHLyBNWQeIBGpkYOH/2TuT6Nv
 wl4Xq2G+Is3aEbambohXPW8ScMhwFfH7aNt62rAsL3ztOcLOUR3Zcs49DwZBJwsH/N59
 WzXlZxDGlr8ZV8LTTncgb4nyW71qyxH/cympNpKv/f58S7nDuW50q/myIgdDv3rmPFa7
 4AFAJqZQ5+oYQyeg89nHSrbkQrsmbunfSHXfpMlQWPcE5/kbK4munQv1HmGyXtRQLWKt
 XmMA==
X-Gm-Message-State: AFuF++kcH0Bf6Hjjj3/VHxj18D8jzbvl90luYa3uGQj4FCV9Zk/B0xW4
 hXlmoVOMI8hfHayX9T3mn/z65JWGvUWYKuWC7TN7nqieWm3iQ7lDCKgDHHSPnScbAk0zRbgeA2c
 yXuoQlTUCy/TsBxEYk4DooemSV6wSSk31gqu2zKTseR6Q12pyxSJC8DL+
X-Gm-Gg: AYBFou09Bgj4gjSXnu4QxRNNF9kIa59XOQ+V1QbraNKy9WsVDMO3u/+KRo3g8Vvs+UC
 p/1LCAK6Jvcc1UpWIWQJIBXi7N1gNxojsoZHCvrkkKNmiiMI2roNUOFqkmOSJGM/ECgQtOimHyR
 Qi39EHaBQxVoFNDdLYZshchAVpVip99UOrarRLNhzhlJrdC3YnsBp8ycheCwVy0d0DcWr0d//Qb
 CoFrTwG0BjI2lhTHCcTcwX/fpzRC77rTx3KtVsEtaJp9X/5Rvf4uU5C89FrPsFlqHSSfAOBVM1c
 lrH8PWEfomPr3n8V6UMXKKLV8aYfjXuxyKjasYtncqgb+0gsgXGDzknlUloaAo1Kc/mVkULatHW
 ZeslphS6wEfyrlPwaRAdH2xhsg5ajhe59TtM0JMtDPkbtYSPXyWYE6hlecqI=
X-Received: by 2002:a05:620a:3941:b0:92e:4927:2002 with SMTP id
 af79cd13be357-939d4a8ebb0mr1062755985a.39.1789043284615; 
 Thu, 10 Sep 2026 05:28:04 -0700 (PDT)
X-Received: by 2002:a05:620a:3941:b0:92e:4927:2002 with SMTP id
 af79cd13be357-939d4a8ebb0mr1062749185a.39.1789043283995; 
 Thu, 10 Sep 2026 05:28:03 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397f9f0734sm1698669485a.4.2026.09.10.05.28.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 05:28:02 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:28:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 05/18] migration: Merge parameter structs instead of
 assigning one by one
Message-ID: <aqKiUJTvI_I8F2td@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260909214509.237309-1-farosas@suse.de>
 <20260909214509.237309-6-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260909214509.237309-6-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Sep 09, 2026 at 06:44:55PM -0300, Fabiano Rosas wrote:
> Convert the code in migrate_params_test_apply() from an open-coded
> copy of every migration parameter to a merge operation using QAPI
> visitors and QDict.
> 
> The purpose of that routine is to update a temporary structure
> (pre-populated with the current migration parameters), with the values
> received from the user via QAPI. As a result, the temporary structure
> will then contain the "to be applied" parameters and it's validated
> before being used to overwrite the parameters currently in use.
> 
> The update is currently done as follows:
> 
> where 'params' is the user input from QAPI,
> for each parameter:
> 
>   a) check if the option is present
>      params->has_<name> == true
>      params-><name> != NULL // for strings
> 
>   b) if the parameter is a pointer, free the to-be-assigned member and
>      allocate memory for the copy from params
> 
>   c) assign the user provided value to the temporary structure.
> 
> Step (a) is the same in principle as what the QAPI visitors do at
> visit_type_MigrationParameters_members().
> 
> Steps (b) and (c) are roughly the same as what the QDict
> implementation does when qdict_del() and qdict_put_obj() are combined.
> 
> Therefore, replace the open-coded function with
> migrate_params_merge(), which achieves the same goal, but uses
> visitors and QDict. This hides the details of QAPI (has_*) from the
> migration code and avoids the need to update
> migrate_params_test_apply() every time a new migration parameter is
> added.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


