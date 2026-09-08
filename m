Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7133EC79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3wop-0007me-J6; Tue, 08 Sep 2026 10:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3woo-0007mH-4U
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:29:02 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3wom-0002GD-Oa
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:29:01 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-8565d77c277so56947247b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:29:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788877739; cv=none;
 d=google.com; s=arc-20260327;
 b=exOo5/36zUQcLkukjL1TR3I5c2PrF4ZgghF+prYnxIgoJf8OvghcABA1WtvUyCNrq4
 jcPk45r4SB/WMAP4R2+inEXn4x3sJ3cy9PJ1okt/5ZI+IXN6BUi8cMW+Ipxe6MWfwFx9
 9ANiNiaV10QkQ8Nx4YrZQR90SvdVEY0pAG5zJJabmu/s3pgI6ntoxanDFrp9FJuyQWji
 PnzBdA8a64eEjUNQC2rB7wd4jtcZMchoAL/D2QD7Yq0ElXDFae/UHS/fwP/QRoOKkEhl
 oHQBvIQEfKTJIuMaDALO7yoz7gJSZ3PNi2qAji58CpVxYpM+sb+sqpJDE9/zrurT//he
 Mr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iU0mz6kdv+btGCGNMeE1F/zmQ5bZZj9/CbJURLHanls=;
 fh=cvwsxPUBVrMhomhsFYJVQSEMcJMBeBcPeM4E64TYwDE=;
 b=NkrIMkMUKoJDzghF75Ev3pSMlnszs0vB6fvlTgI+h8zhnMnIv0QY9PTmPGHEpeuOOV
 5YKV6u/pgos1BvE07z6XrCiu4s4yHeZladjDdccSb/pateyj8hBDaCyQNVvUC/iqOyOY
 1MTOkNidNdDzntoT1nkxGh2aqTFOH1Zo5KjN/RnZvxXiF2X14nQBeYnWuz6EFe5t6Pgu
 nr/19r/Nl63u0aepVWdokEJGYFKlwYNmOv0UlTES6jUJpG/Wso5lYtwmRSQehnaQoPZv
 Bq68nrDdh598Jc/cKpSg5XmnroPp3XZeeyEFMXa0BsyDjMOlkxd0j7lGbYcqfS4FqEow
 oIxg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788877739; x=1789482539; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iU0mz6kdv+btGCGNMeE1F/zmQ5bZZj9/CbJURLHanls=;
 b=eZ0D8z+zlY3quKG5oP+gBVoJGnot5NWtANHM7JsUFl41bcCq7XcuAnM/x332TkT88E
 VE2uKOb6w5hEURYDHQc2MsFDJyrMA/c9qre5i9CszkXWCq0XRb+JLWsp0YodJcEVkWAH
 iK6FeaIo/+khFfbHTE6pM1VSdehBgJVHySRuDLxeG9MTdeUGeqD92m41ITEyRrN22Xll
 r+PMhH+YNR7huEFAdzAKjky6852Q7hTK5sQpl/w2asbeBaOsXVMV6QsveZXSUUo/NcOg
 wUPxSn//XryBo3Ag31L3QBZdWs2YnOcnMWOD0020iWkXwm8fIaXWdS0jQcnI9ZjmhDPm
 n8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788877739; x=1789482539;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iU0mz6kdv+btGCGNMeE1F/zmQ5bZZj9/CbJURLHanls=;
 b=dblLOy85RXoKeQpB9fMgy+hSJJ7exccyOSLGxCO8gNsItb/yqL5QxzXo3i/AFHAPAq
 ll5Y0K8bTTyBm9v/4+McFyRd4shUSrKK8Fu/KoD8fOlQqfwA7RPk3IICCbiyw5HLKwzh
 7sV3efqk9W3H47voXOUFpsnSIo+4n4UV1UXkavoBKHsswxBS9PnKy24mMuevCgZ2I9Nu
 7x3uFK/YQxeRW3KSXQQNUmbCpkMDcVvTmWERkyH8x2FZhCO8v1eiOsRdubZneOjs4Wam
 hvy+/8Ge8hK4V9GEIfkOH2mtTHteO9/P2HmZpNlS9kSWN0HfAfKlbeBRz2YKO8wXpdYN
 +1UA==
X-Gm-Message-State: AFuF++kMiucVIxFVpyVl/I4j5JYxWi53Nq2skA/oRplY36BhcH3RU9oQ
 7ak9OFkpQlnrjlFk1+9X9U0+AiWDR8WS4X02M9IKGbQB2NIa6Ea/IO5P5GOlCQoqax/CGPMJeUN
 uJbwxefanlCLnl1NnLgRdIk4ErbVORvYtTKxVNSawyg==
X-Gm-Gg: AYBFou1DOJw6QLlDWOsh/LeLkRH4Cwr5VTW73h2B7mve5bM6g9oMzqG6pXcsITlJivz
 fjNV27/wVyftsGDlRfdD+futLunLzpdxS6zhL57FgST7QXwRU5dYQvwhb9YKQBARKbp/+nScLpZ
 LY5+aaAEpo1hTpcQ95xbV4BwemQJ0fmm8JmdgZbcExvnH1MbGXLGroIe1aQhlpZKYIxQQ4cqIZn
 aDc8ncXJ86L4ldYujE4qEfm6YKxrMBVig9U4cK7Xw0J2RDU3GW14EqY4cDoonqrFJm4jDM0zcGV
 Vg5d6NOkZduSuoSKLu/oh7KS7vUabsC8yKE/QBLqlQfvxPIc7HRk6IfeZcpYAMll/CeQ6WQs9Bx
 xmdwGb/qzV1o9mzjv7qSAH/eMI0UC11jcve1lHI8=
X-Received: by 2002:a05:690c:dc3:b0:873:5c6b:a2f5 with SMTP id
 00721157ae682-8735c6ba5bcmr76548277b3.35.1788877738862; Tue, 08 Sep 2026
 07:28:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-2-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-2-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:28:46 +0100
X-Gm-Features: AcwNN1V9CDkD0nR06MkcgMkFhZTMILbQvpVw_KjM24-7eSO5qegYFiCBNAAAM_g
Message-ID: <CAFEAcA9T+T4-n4yFT9XPPzDCyRwuSLB2TWSkCgMdFhRdTsELHQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] sbsa-gwdt: reduce code ident
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com, 
 Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Wed, 2 Sept 2026 at 13:26, Igor Mammedov <imammedo@redhat.com> wrote:
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Subject should presumably be "indent"; otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

