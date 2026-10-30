Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A21606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=u181vLHX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMmak-0002pj-IN; Fri, 30 Oct 2026 09:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMmai-0002pC-Mg
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:24:20 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xMmah-0006Rn-Ag
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 09:24:20 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b10ac6ab7bso5999797b3.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 06:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793366658; cv=none;
 d=google.com; s=arc-20260327;
 b=YVdNKPjkn+atnzYuc3wJ17mTs7g1sDoLnrEFJB5/Oamkb8dY1ZylXkP8IMQpX0399h
 /QJQ77Ciu7/QWFs1aj8HULifUcrqP4Ad34M1F7jVLf6UBXvp7n702K61xpse9dm4bTQ8
 chfB4XKCAgFV0jeCZPMX4jfnMpY15OI4YhvP3ZGMGYIbsUJkHaAm+IB5i1QOlx4tJElW
 3vgH7GC3bxhQTuBi4ixZ/9chEnzAy88gsIFhSDR7TEemg8C58oJgDkQXFLs4tSceHSe0
 C/PoLkrOdIlvRN15IdnwZ08YnSl8pIE9fchfdIFzYvmS+eCRMkpO8tWh0u+s6DarPMfW
 gARA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Zh0klMc/byD8klEQMo1lKnHHSoxDXyOKSTywb5KwxHQ=;
 fh=GGSrIBMEclvrn3eB+XzlWtsnNSyGs3PrBavMwBQsE+8=;
 b=qNIfttdMBGzJyMC7GKBnuDLQntr+8q6mndQfzQoadndS48AgcN0bc/dKFjE5rwJ3kh
 WJ7mOtIQYk4dqtNFON9CzdOduBzfbEPQg9K+eyLjn1ETyMxVI8/z7PKkJwKgPmHF3el/
 pIhaSSP1jhtIKKtnqk0aflcoR1iYcawJD2LDOWkeuxqknKwrSUYJBVEwE4EwHpYfHvC5
 Ei01VazV+IMmPM4fXeYDGWL3k60z1jO0z9VhMANEvGaNMkKW2EKe5QM4I2ndHpJQOKju
 FOmwX0IdllIkVgxW6qA4VzaYO2q3TyC6qBXKq+w/FTFcdHFjfNhfYXl0+UItTrNfCaZ3
 1T1Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793366658; x=1793971458; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Zh0klMc/byD8klEQMo1lKnHHSoxDXyOKSTywb5KwxHQ=;
 b=u181vLHXoo32IofuC5SU/6fLjxxmc6Rp4BBA3rdq/fUAgmd+E3GSTu2eqPw5HhVGTF
 5kVfeSKnXd/F8c/gPzfgWJXKOiWgCoDIlzSk7XZYjQCWwscPTs8TYhEPoZsFwFAApByc
 RHe42wV9jsdwqxiHKsU+837upNxlJUf0RfyQ1qZK4KjQ5fowve91KqDfFbyXJv5kEnfV
 k/aEmGUeWknPZ/4yR1RqKx6AOKOus0tUO5w7PrnHFoPilTf4qWVuCr8SI/e0KHffgKKe
 fSVf4tcinNsFX3PXxj+jWMz5VcTXJQQFUYRZeEmQsUBmJTnozEN/D2e4iiADBWkLvN+v
 4tfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793366658; x=1793971458;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Zh0klMc/byD8klEQMo1lKnHHSoxDXyOKSTywb5KwxHQ=;
 b=EIkkzFATLwN3ynvy+MO4hep53i+4RuS8XTi2PrhvUcDLaeNE55SFTr+50cuQ7k5td4
 4x9RCTM1ouyiMDshK86BadMRuev9knDx557LS6qvexMVCfwN+Y20WexFJ0+NQ4IkTETj
 99crDiqAcIKCAW/kRTWolgwhIspNN4Y9//hXwqXcgSso5WdBqhsmdc77V2OAMxF9vhbe
 ITEzQvSgHf9j8Tdy50IJyzNXv9jKy/8KyWXBk2UwDnl4MoS4OnBmIN+/oySMcw25GVAz
 7jWvJJNyQfit43BB5NBYaHOHe48b4L6DULyHv+jXUHO8hGLflOitrQfk4IS+n0lOsHGZ
 N7uQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxapNYHfdA3ThdRYx4nJ8T2uOANG+ugcecKhfZN3hcb02/jHWjK9xPzfSlAf0NxMH137UOYlZEr/APE@nongnu.org
X-Gm-Message-State: AFq9FYJ2Q96UiWkBAsB6+MR/zOkye2J4n+Enw5cwh7i+gYcrhpMXLjgt
 0V0lb1wwp6qszo7LB9qSBqI5w9newKoDr0Rp0sF8VmALSIDBvdgMzmwFWY7HFLvPaZJbiYVd90k
 L3WHAVO6fpJiV6jWQukvehL5RCDBWxJl+eWIRlYRVuQ==
X-Gm-Gg: AYBFou33xPqSa7MfFpFlYt5lAcwD9HmKZ22jqjzk60qXoDiZgtOvPIYEtW0hWdYVn3d
 sP6ZXpH+jl7uEuAq/eBWzwgpLHxOjz77VWBLg6EwjoH5pt6p68r9i10Ih3tIU1X3ypZXc9SLw+m
 rVpgrAn/xPb5XnaaAUuwAf49hgB/+axSAMfhauiPF14WkC958Y7IJKD8LhwF88F21iOENM+Gbxt
 /oSFYmBemKxtWbt5KoCrQIZZJu8LJwKuJNpBGNJt/ZiD64PdDB55Va+jkqVA9G3nfAn+0MPq0aW
 9TOD7+NpyW7SbVowyIMK1tskLmh/BNPePPkHctXtQrR0TUsecvrHU6PiYwpBOh6ro5YPWnL5TqB
 OF6yFSbKnRPjbQNrlBWWdgr1DJsGljEK+c6nqsZ9TW3Q8leeCUV4T1xD7rTbEeYsfSVOOd7yasg
 bMa1b3+wcES4lRW8AFalWk
X-Received: by 2002:a05:690c:f8a:b0:8ae:88fb:3e12 with SMTP id
 00721157ae682-8b2b67babf9mr14041797b3.61.1793366657834; Fri, 30 Oct 2026
 06:24:17 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261030131406.461599-1-eric.auger@redhat.com>
 <20261030131406.461599-10-eric.auger@redhat.com>
In-Reply-To: <20261030131406.461599-10-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2026 13:24:06 +0000
X-Gm-Features: AclHuK_NhxH9SQYIqT84fpZntkgUpapM4hWVMvLS1XY2v76ZMswonXdxEnMxK7s
Message-ID: <CAFEAcA9ceuoQOq5EMys1Z9V6CJZkgUB2UuVoBhac+fy_5sc3JA@mail.gmail.com>
Subject: Re: [PATCH v4 for-11.2 09/10] target/arm: Directly store cpu probe
 failure error
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com, 
 richard.henderson@linaro.org, pbonzini@redhat.com, skolothumtho@nvidia.com, 
 philmd@oss.qualcomm.com, 7746591750@163.com, maobibo@loongson.cn, 
 harshpb@linux.ibm.com, amachhiw@linux.ibm.com, 
 daniel.barboza@oss.qualcomm.com, milesg@linux.ibm.com, farman@linux.ibm.com, 
 cohuck@redhat.com, alireza.sanaee@huawei.com, armbru@redhat.com, 
 mbawa@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, 30 Oct 2026 at 13:15, Eric Auger <eric.auger@redhat.com> wrote:
>
> In case *_arm_host_cpu_features() fails, we currently
> record that state in cpu->host_cpu_probe_failed to later
> report the error on realize().
>
> Replace the boolean by an error handle to allow
> more relevant error reports.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

