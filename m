Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A64BC982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7MDj-0003NM-Lh; Thu, 17 Sep 2026 20:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7MDg-0003Mb-1z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:12:48 -0400
Received: from mail-pj2-x27.google.com ([2607:f8b0:4864:39::27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7MDe-0005j7-8F
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:12:47 -0400
Received: by mail-pj2-x27.google.com with SMTP id
 d9443c01a7336-2dd77300825so1723125ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690364; x=1790295164; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=jXP2919FVisNmiCCtkt7g+fhepVZbAOAHp8p9Hho5rs=;
 b=GrMD5osWVIc5DwUK0CliszF114eYg/z7NUYVVANTL7WbmQr+PxMdZAEu69tncXG7Yw
 5LZ/f9iXbJjolMxhyjFwDtIkQtcrXsnEjhtIAsmLR6G0M8BkHDALNU1eygf44vbRYJUn
 qa0p26Jz0Ne8OOvajX9dYZxDX8EqBhis8f59PA1GGjjP+OAXoqJEzPCraQkFZBb7zlnk
 Lf05aFfKSGxRNfmHQe5NM7j67PO6Cj4cdnX5kPuwpLYYywqX+cS79JHPZBwpt0vPKybS
 eOs5cg+xPjS6Jagb5rg/Jx0tGGPNYPxVhkIeua/THqxugLx8KEt/uFG/HHwQhI/MX2vx
 VYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690364; x=1790295164;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jXP2919FVisNmiCCtkt7g+fhepVZbAOAHp8p9Hho5rs=;
 b=HEAB3Lig1T/hgusoOcp59hh91w/v0MKahCgCUxOOtfZ47wy2ytKd0eGEVRfq1td9zs
 51L2NyKsoxJgUv2Qzg/hfMTHs4Cz9RfG6gy0dtWkjyuSCWdhUg3OzmE4GckASK9HMmso
 FTzDmKBZ0MJqQ6EnjrcuLFz1jiFJge4YNh5NyuFTkigwP7VEGrwA/9cetbxi6MoPwDPi
 rBypVOd6X+NYVpYNah1GCXkNTw8GoqVPhc65sDGZwyoT75ZbZoxq/2m04BXW9+u8PLEC
 P3/8aQ5ZcadevVikvgrOGzgRRbFySjt21jy1Sjo/A0cnHT8rERBOv09j7E4KO3H5aXCo
 Qc3g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwhTVGryFiAiFRyZItTOcztn5Oa90/s/ahZl+QnU4jP7IufDdtYeNNh5IwLqUMR0WI4NAJMjYZmrLTn@nongnu.org
X-Gm-Message-State: AFuF++m63S3+Hbbx9WA6Uv9Z7VSgb2/rHKjYovXGTdc/KohyiOFnPkbz
 /DKls7LlqFbm0GTtsOX02GAKKFlXMhgdvNmR8dskYeyikt1mmG+Ty+AW
X-Gm-Gg: AYBFou1brOzGgH3NhnnzEcfnHbjXhWG42e0Z1nOKZBydxIixvX41mc35bgM2f3eEE+R
 wFzsbYe2o3MbcAi1T2VzVJ1zNhex+pl6s9cfVOO5YqjDIuOmUw4F9s0XzLw49JtY1VTg646n6Nv
 52Y9iHeoxadssxfgAFnAstL3WkwQgWtjm9RL5V7glC1gQdZkGT1f19BfpPefNb3wzGFu9f8IQG3
 H93lQR8AoAra7RlLBAUnLJ3Ir3re5V29j6To6DbAPQG4sWdARXvSYolIYQDA21A/ACj83r6vb8i
 pkYnlPXWnCD5iQ45hPVZm47Qen3YwCy5i0sRKE8hMzvq5uKG/x6rHxhEel8R4v3Brq5nj/ktIWk
 0xIhtxBsyqA+nwHwKqfu2qAbPiKZc1unozeWo0n1yMYJI4QhTP7cS2d/ST8oM4qsv2Ejt1/v7Vf
 KBecjVeDfCTh3Z4dZ0mwf4eWmdIPbj3f1UGk758HM8N9XmskX4AWAxYDlU0JyP7rkhfkARSSpaP
 Ayv/vRxHwaxYUWTlQ==
X-Received: by 2002:a17:90b:4c50:b0:39e:4c7e:f03f with SMTP id
 98e67ed59e1d1-39e54f6a423mr1559194a91.28.1789690364380; 
 Thu, 17 Sep 2026 17:12:44 -0700 (PDT)
Received: from [192.168.0.22] ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e36171944sm8530822a91.7.2026.09.17.17.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 17:12:43 -0700 (PDT)
Message-ID: <d85e012a-1ee2-4678-994f-bb46a93151d8@gmail.com>
Date: Fri, 18 Sep 2026 09:12:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw/ufs: Reset controller and MCQ state on HCE
 transition to 0
To: Stanley Jhu <stanleyjhu@google.com>, Jeuk Kim <jeuk20.kim@samsung.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jinyoung Choi <j-young.choi@samsung.com>
References: <20260902081610.2290123-1-stanleyjhu@google.com>
 <21bbbab6-192b-4243-980e-4167b450c478@gmail.com>
 <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
Content-Language: ko
From: Jeuk Kim <jeuk20.kim@gmail.com>
In-Reply-To: <18d61b20acd45382.3137322e31362e3131332e313435.ea6a.0000sendgmr@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::27;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj2-x27.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 9/17/2026 9:22 PM, Stanley Jhu wrote:
> On Thu, Sep 03, 2026 at 03:06:42PM +0900, Jeuk Kim wrote:
>> Thank you for your contribution.
>
>> Reviewed-by: Jeuk Kim <jeuk20.kim@samsung.com>
>
> Hi Jeuk, Stefan, and all,
>
> Gentle ping on this patch. It has held Reviewed-by from Jeuk for two
> weeks:
> https://lore.kernel.org/qemu-devel/20260902081610.2290123-1-stanleyjhu@google.com/ 
>
>
> Could this please be queued for the next UFS or block pull request?
>
> Thanks,
> Stanley


Hi Stanley,

Sorry for the delay. I was away for the past few weeks.

I've just sent a pull request including this patch:
https://lore.kernel.org/qemu-devel/cover.1789689763.git.jeuk20.kim@samsung.com/

I'll also catch up on the remaining UFS patches and review them next week.

Thanks,
Jeuk




