Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB9810F286F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 21:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Elz-0003YB-Lm; Fri, 27 Mar 2026 17:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6Elv-0003XE-6q
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:31:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w6Elt-0005Lu-P9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 17:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774647073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PUI+iptfIF6f2fhx1pDkASoTPDEFIG0hDB0zsAdPlgo=;
 b=fV3Ejvfnoid+qnQQdvrFTSe686XhSt08ghhVjZSz+DUijsX2DNbxdePTJdJVpIOn8BTwwu
 2Qm++mDIm7zm6VDVYXo+TIpY0jI1YPbgorMegQN2BvJ30pBhfy9ejuo/si7Txco2uzl2fR
 nwlpaNFY4SKV0kpsmQhllLUrRsnsD6Q=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-kXHmReFFP8GquNx-FKGDbw-1; Fri, 27 Mar 2026 17:31:09 -0400
X-MC-Unique: kXHmReFFP8GquNx-FKGDbw-1
X-Mimecast-MFC-AGG-ID: kXHmReFFP8GquNx-FKGDbw_1774647069
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50b802961ecso35220021cf.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774647069; x=1775251869; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PUI+iptfIF6f2fhx1pDkASoTPDEFIG0hDB0zsAdPlgo=;
 b=BSdpObnms1hqT8tD1f6QJgblzjv47CAZiiCt7eTDhAgDkabeVjDiO/DpZmRXPBucB8
 84xcwYcE76bnBy8QgPVWrnytxCdQoHnrPrnCD5Ekbmplen2fipuE1YTMJ5tnUwsYBHo2
 q1jX7qh34nf2C3OEn3Zl/Js6GsvDlIOR4FLpf5hpSjZy5WYz1E2sBCOq1tcsW9EkqyQB
 Bz0nqFczzP2G/xMgvuTn4IcTe+0eS8JUsIkHiZZdlltnHlIQXMTgzAMphf57Lj2AnNFQ
 zvjoWUN6oqOhYoRHD7ylOetwZpIzh7M99smIe5jcpSokiJkoGwv914C/GZcn/9dlWm4c
 qP7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774647069; x=1775251869;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PUI+iptfIF6f2fhx1pDkASoTPDEFIG0hDB0zsAdPlgo=;
 b=Ou1j44DvJVLpNFBrnA5smgBOfIVNv0K5cT9lH8bDMXRDtlh5I4wswlOWabDhjydNG4
 6K4D8U6/gGhmz2KFhds+BvSb+um88tCvPr7dbEmYQP6CRw1WHzy2NDHek4DRGrbDv9uF
 BJiAOePN9WjFaCnfiWFtVZd9eFmCQ+ZPkxrepurKrUx0l9ma3aRed7nU1rvKRL4zbYQf
 R1DGPk9fBZF5At+qzPQyvP9DeVK6gyWlSe2T7IIVe17EOp+vdM+qYADup2gHs655nsk7
 mh32h0HHzoqAJSP+giWXKwE8QYo9tAyg5OEDGib1dW3OkQjJk0Jy8yol6HKv/75ld9JO
 MNbA==
X-Gm-Message-State: AOJu0YyJ48XptDN/xOb6GWWBNwxJbdSUeLW9NsFi1wdljPlQ31Xt2KmO
 2VZv9s728O8oxi4luFDH/ynzv+jXSEXcQa0qwkYsASTUU3Za6YqYlLTKdzkuLmFxzQW8mjxSK7P
 MrLskMF2zvdJHHuQKp2bwZX8ahxcEatRqW2Ew+FSHKGR/J4zbtzoqnApa
X-Gm-Gg: ATEYQzw427YoiPLFRiN6u+tFrt84u0QnQzIHZKBDV1LtcXtc4yNlF3I17fokH1EQF1P
 sVXOGe6T8+qOvQw8oWZphqx6+6QZNNHLG0MbwTclouXmIu2Fa9MVxhoebdHbZZJPamp83CBGXHb
 qF2b65Ut6iCk+euEcOBdG6tmKwX5ZwhfijIocMfatFWPCO/+9FISowa5YlAIpP2TgZMm2ZosAEt
 IVInK5NGxtLjhqFG36Eg1RBDGuOdEsJiVg02gHMd5NhsBaUuOhy+x4IMWAYQnbXPqqwprFxvcbN
 Je6bjSuM1be4kcRZNpSfOCZvlx1kjJTSItI7++zj7AeN3qZvYvz4X/QqSldjANEorj5wZy8dTLA
 dDZvLOmwzAeXtiA==
X-Received: by 2002:a05:622a:548:b0:50b:34f1:6309 with SMTP id
 d75a77b69052e-50ba394cb72mr52843661cf.49.1774647068908; 
 Fri, 27 Mar 2026 14:31:08 -0700 (PDT)
X-Received: by 2002:a05:622a:548:b0:50b:34f1:6309 with SMTP id
 d75a77b69052e-50ba394cb72mr52843251cf.49.1774647068312; 
 Fri, 27 Mar 2026 14:31:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50bb2e0fe31sm3681511cf.20.2026.03.27.14.31.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 14:31:07 -0700 (PDT)
Date: Fri, 27 Mar 2026 17:31:06 -0400
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Glenn Miles <milesg@linux.ibm.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair.francis@wdc.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-riscv@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Anton Johansson <anjo@rev.ng>
Subject: Re: [PATCH-for-11.1 03/10] migration: Revert "Add
 VMSTATE_UINTTL_2DARRAY()"
Message-ID: <acb3GtWg9Xw232YJ@x1.local>
References: <20260325211728.89204-1-philmd@linaro.org>
 <20260325211728.89204-4-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260325211728.89204-4-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Mar 25, 2026 at 10:17:21PM +0100, Philippe Mathieu-Daudé wrote:
> The VMSTATE_UINTTL_2DARRAY() macro was never used, remove it.
> 
> This reverts commit 4597992f624c015ceb51fedb4628b3fdb1e5bbaa.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


