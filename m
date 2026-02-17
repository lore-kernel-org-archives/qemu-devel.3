Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF37E909A4
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 14:13:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsLoG-00039c-7n; Tue, 17 Feb 2026 09:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1vsLoE-00039J-JF
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:12:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <abologna@redhat.com>)
 id 1vsLoC-0002Pq-Ul
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 09:12:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771337530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s7qiaiS6wuh70utlPYCUUVu5trQ6UCLvL4ll0mnFdDE=;
 b=ICM0c9RkQjFyu0oQnCQ0bl3TDARTcFZ0YFqMt7F6MVl/48L7n42oFgi2NAx1HkGEWadezx
 iATSfh1fJzNkTxqRizzaU7O6DolxccwKWca7pLIpuU8+8FbIsW+vWv1af4zTrKNzxDTj8L
 xASFIjaIDtNbC4wMMDSzbpj1qqP3lb4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-R1DjMl7MO3eVmvWPYUeLSg-1; Tue, 17 Feb 2026 09:12:09 -0500
X-MC-Unique: R1DjMl7MO3eVmvWPYUeLSg-1
X-Mimecast-MFC-AGG-ID: R1DjMl7MO3eVmvWPYUeLSg_1771337529
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50333a8184aso376259501cf.1
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 06:12:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771337529; cv=none;
 d=google.com; s=arc-20240605;
 b=ldAXq28uHXODUapcL5edaablL8lgv4iMThuYcv8tNe+CcOvLj4cgwI00lMhntjZVup
 Uwg1EMOWDdwWh+6ImoN0tGTgU0VyO4DGjPZRHrvv7O6Zzf7optV2+GQ/jOD5kI32CToa
 pN8kWj2qnRzM+YRqQcDXbhD8NCguro+BPE7xEfpx9C5Pvd6Q/SMU1jLk+c+tAQMjQjXy
 P5OU2t+N+j43ykp9n+cZIpxJbRp1w7ps4m1Sc3aYg/NVByqcajKloxfNChQabsfZh5Dw
 W4o6x1cNA/2oV/HN6AnACiXPrMQ9K0TbJOA4YefNLmp5ximiFDYzpz2aNjOminOGP3Ba
 ufJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:dkim-signature;
 bh=s7qiaiS6wuh70utlPYCUUVu5trQ6UCLvL4ll0mnFdDE=;
 fh=2C0xC2btyZ0yUwTznCM/Wb1oCI7xXabVAPbwD95UD1k=;
 b=SHXVIRXcp7NsdJbrY/VgbeAO4KAVniEDWpFR5RlRQmT5Uqq4Zeh1ML/pDquBT7rbns
 kalkmSHYUk75s++pImX+Z3lxht7AbU72osn3h4d6bffo+ZOZRoEaG58ECZO77OXNjVRY
 4gRGifgk+J/ciW1u2pgpl+B9h4vyo366tG24NLwoLX9r0CEf/lRJUEyJplxBDZMj4+Hb
 Vy7nOPSk4hxQLymLZKTZbaJoGwbEbkV5/hJBgsUf6k0M/b8dKvNogogpnHyQ0CguRC6W
 lwCJC6eOwqPZ0owOR665o7wWaYQ0naWFIiaFmC6p0/hwUUGyfWHnFexSQHIIJS3mq8Wp
 IG5Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771337529; x=1771942329; darn=nongnu.org;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s7qiaiS6wuh70utlPYCUUVu5trQ6UCLvL4ll0mnFdDE=;
 b=gfixXbIn/uRVD0FJLYkNimIoayXN2cttTJb0STZ0HUq/PF80pXnvF7LdxE+au4fPo9
 ER4GgT8wYl4byOpN2WC7YbWkb+wkX04IbfVkQxXFjoAMnc72HBMEhecQ8eO7usmFfzfa
 u1eNMAQW+mO0RZxr3XuVOPAOzKJIITWqGaS/crBdu0VdilfDL2YYxdWD7PbYT9qBU+Mw
 ho2YnGMWPDShKm9SVKqEKsZQ3sHjyGYItBzaFOys5Xsftrm0vg2GZpswcPZqu3Vf+UDn
 ZuvdDB5IG3usuoOfPaty3hy0YSbtg1E6iI6keaO+qcXHa+0LkHyWROVHTw5DeZm6c4n+
 edPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771337529; x=1771942329;
 h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7qiaiS6wuh70utlPYCUUVu5trQ6UCLvL4ll0mnFdDE=;
 b=MfYjuB27Uoi6geQZqBsXRfrKzBQZ0J/axCN77wcRI2r/xO62scN9z9MRpptTCaAoGc
 LNDjGG0e3xS5cbRrsYvJAWwSFxUNaVl1qgHQYwYnkivnacgU8Asd18h2WHgltvf4HR6R
 pdUTZj4vDmwM2jrM2I3Y54ycxfBhOAOGV7simyBn/tIdFl7Zzo+jv3wFzKbkgfq8cjBj
 DcM9fVSZ+8uGrPd/hqyKune37tGOtWubjNsS/fnh+tGS7q2UOHGjtmgdXDscUsziaOJb
 ewVCOHF+7RMg3rhlAWV03Ohh0UMrD7mfuwE0DOgcymvctNlr7xrEQVpbx4Zg9ufzDoLP
 E03A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUND7+Kkvcek7X7Ofc8+V8I778nY0B+awfnUcKpwrIyg5RK8dw1aPRYZkYYT9I8VM8T5HyjI6aNxLwV@nongnu.org
X-Gm-Message-State: AOJu0YyU73WJvQBdscdAptKqlNuX0E6J0dBx8qFVLt9EE+4N0WJxSZtm
 uhsvZ7gCRsRIaGz4RJmLHfNvq/nYNnDs33j1eyHwPkp2Y7MwzfDaN/QgGfXJf8sjtDvNyaejBKv
 iLZ/fPQ+Rw35lfqXmmfAwnT8F8zU7KA83XdOfKvSG+4kJPP1PNaFpDM60MO6rHgrvkZeuDd5hWd
 Tj9xpAw5x2I8GILYOg1b7x7PcZDrCbdaY=
X-Gm-Gg: AZuq6aJCfK92zx4EvN+OHlWXkv+CqfH+PXsOWB95ZP2OOtpe6TigYAq1DEX9mIwVnfv
 U79louDnVwgwFr7rouTWk03X7xd+qz3iGOtGOz9/itGiJCxmKUsLCgjjQnwyH70IDEDU9HOQqmp
 5xWUPRdSnGW64rJQXHyLKp9T+/QY/ATW1//sq6pt2L7KNLJ3atFwvEuKatwxCzCCJZCRqjaxazE
 oLxDTQ=
X-Received: by 2002:a05:622a:1787:b0:4ff:c5f7:f812 with SMTP id
 d75a77b69052e-506a832dbc7mr186720211cf.38.1771337528757; 
 Tue, 17 Feb 2026 06:12:08 -0800 (PST)
X-Received: by 2002:a05:622a:1787:b0:4ff:c5f7:f812 with SMTP id
 d75a77b69052e-506a832dbc7mr186719781cf.38.1771337528404; Tue, 17 Feb 2026
 06:12:08 -0800 (PST)
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 08:12:06 -0600
Received: from 744723338238 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Feb 2026 08:12:06 -0600
From: Andrea Bolognani <abologna@redhat.com>
References: <20260209133906.294720-1-abologna@redhat.com>
 <20260209133906.294720-2-abologna@redhat.com>
 <87seazn3ep.fsf@pond.sub.org> <aZRStq9gJVoe9JkT@dobby.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <aZRStq9gJVoe9JkT@dobby.home.kraxel.org>
Date: Tue, 17 Feb 2026 08:12:06 -0600
X-Gm-Features: AaiRm5093n2UN8KJhuYroqshrKKp2Q8glKZtTPKHK5SIDN35obTr4hU3f1sQI1c
Message-ID: <CABJz62PS9aBOdm1sXd9FXL_MCY2CHhHDJJpJtqu+TGG1fD1LVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] docs/interop/firmware: Add 'uefi-vars' member for
 FirmwareMappingMemory
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kashyap Chamarthy <kchamart@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=abologna@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 17, 2026 at 12:37:15PM +0100, Gerd Hoffmann wrote:
> On Tue, Feb 17, 2026 at 10:08:14AM +0100, Markus Armbruster wrote:
> > (Since 11.0) and indent like this, please:
> >
> >    # @uefi-vars: Information specific to firmware builds that expect the
> >    #     "uefi-vars" device to be used to provide access to the UEFI
> >    #     variable store.  If the mapping contains this member, the
> >    #     firmware descriptor should advertise the @uefi interface from
> >    #     @FirmwareOSInterface as well as the @host-uefi-vars feature
> >    #     from @FirmwareFeature.  (Since 11.0)
>
> Fixed up and queued.

I sent [v3] incorporating Daniel's comments too, maybe you've already
taken care of that but just in case please make sure they don't get
lost.

Thanks!


[v3] https://mail.gnu.org/archive/html/qemu-devel/2026-02/msg04422.html
-- 
Andrea Bolognani / Red Hat / Virtualization


