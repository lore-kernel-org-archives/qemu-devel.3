Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A63E4C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 14:41:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI75w-0007Vo-EI; Thu, 22 May 2025 10:40:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI75g-0007Py-CY
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uI75d-0002DK-5H
 for qemu-devel@nongnu.org; Thu, 22 May 2025 10:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747924806;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=234H6DpL/3orM4ZjqyyMst2tXl5uXKkanqmnsYrXUzA=;
 b=OnLWAjR4cZuM2CUFSqJ/i+hLBYWKsfB19CDcurfgkUQXE9OqXaTGsEbLJLXRfdAbHxyCt3
 17bv9Tmpcuv9QN+QDCFTLcxVvlpyY7UgFg9m0d3S7ooidGKgNcvQAzAczMr3cdd8QeGSQO
 w3JBlY9pzIWxHuRTfL6IvgmRfiFpWjw=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-yZKzXH2CP8iozUhaPFcASA-1; Thu, 22 May 2025 10:40:05 -0400
X-MC-Unique: yZKzXH2CP8iozUhaPFcASA-1
X-Mimecast-MFC-AGG-ID: yZKzXH2CP8iozUhaPFcASA_1747924805
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c791987cf6so1708148485a.0
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 07:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747924805; x=1748529605;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=234H6DpL/3orM4ZjqyyMst2tXl5uXKkanqmnsYrXUzA=;
 b=oSNvBhAZmnPDelHH2N8hy0ekOEn13E68ri7I+E/Sn4Cn3Z8AvYO2kv6XKs8FUq68hU
 qxBhEKbySt154RefdosUHsgzyoAgP9h15CTTDPXvL3QXWTrebpZ84RFLS1CWMWMrCoeF
 KC9PDC76LNeQLBG1Yjqr4b7nUarF+pun9fPvItXoC5AF09uu7XiWtrEOh9dmwZqoRV0Y
 5nX0nEW9X443mDB/2Sbd5gQ77HbqIzoe/QmL1K4ZLGraRfW4ltjTF30VAJ1IoaNT2dLh
 JZM3VffS9zMIvszbY77taE89jj2cm2BfPtzxphoc8jgf4jEkwq7IqkhrUuNTPBU0eqPv
 JzFg==
X-Gm-Message-State: AOJu0Yy3pVeLqdxiYWyBU1FIBGM3tjEpGrXbtMN0BnHRE2kaRKWjkr/R
 movyCGuce/ms34H9PMc3sk9VfAgdmMhAMLpfF1w3lxiHU/oj+FYVgiMA3ZdSkv8C8NlDz5wBIoy
 iEf9ttegxY++M3WY/5O3HMMdXIkJcee127pPcgxaVFyYVHBRbvlGQJoBh
X-Gm-Gg: ASbGncumrpzWHd+SBN03O7GlDwY1lyAS7TUjgEWXCE3EfXXVSLtYOrbcKwZtvXrqBWI
 iit9cyDUEBw6juNL3GI+ct5pqUnyC4hJU27D05hVn9VnF01V76xU0uBmbQXvcGiGfCz7utP5NJ5
 8s0fd7lL27Aa2GcxtkcBFXKRHKUGq0LD8nrOTRmuFlAaLdF+ya20NWSN59L2ZnSlIMGuCl2O5fG
 o7btra12ylVsoTj81yV3BS71jodvIRHt1AVeKZENNzEfVXNsgalbqv2jgI8ojuX2vxKrV+rECae
 k68=
X-Received: by 2002:a05:620a:2847:b0:7ca:f04b:3fa2 with SMTP id
 af79cd13be357-7cd4679cf74mr3577037485a.38.1747924804838; 
 Thu, 22 May 2025 07:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5WmcG3Sfuc3tvv2YfaVZpsa11jfve3Dioqpu6a8HTHU9+FMMyvzBwPjHawPAH3RgX0j6pFg==
X-Received: by 2002:a05:620a:2847:b0:7ca:f04b:3fa2 with SMTP id
 af79cd13be357-7cd4679cf74mr3577034985a.38.1747924804491; 
 Thu, 22 May 2025 07:40:04 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7cd468b6bfbsm1036670685a.73.2025.05.22.07.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 07:40:04 -0700 (PDT)
Date: Thu, 22 May 2025 10:40:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 4/4] tests/functional/test_vmstate: Test whether the
 checker script works as expected
Message-ID: <aC83QUmY6B255lTb@x1.local>
References: <20250522133756.259194-1-thuth@redhat.com>
 <20250522133756.259194-5-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522133756.259194-5-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, May 22, 2025 at 03:37:56PM +0200, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> We've got two vmstate dump files in the repository which are meant
> for verifying whether the vmstate-static-checker.py works as expected.
> Since running this manually is a cumbersome job, let's add an automated
> test for this instead that runs the script with the two dump files
> and checks for the expected output.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/functional/test_vmstate.py | 37 ++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/tests/functional/test_vmstate.py b/tests/functional/test_vmstate.py
> index cc988987481..19a62e8a17e 100755
> --- a/tests/functional/test_vmstate.py
> +++ b/tests/functional/test_vmstate.py
> @@ -9,6 +9,22 @@
>  from qemu_test import QemuSystemTest
>  
>  
> +expected_output='''Warning: checking incompatible machine types: "pc-i440fx-2.1", "pc-i440fx-2.2"
> +Section "fw_cfg" does not exist in dest
> +Section "fusbh200-ehci-usb" version error: 2 > 1
> +Section "fusbh200-ehci-usb", Description "ehci-core": expected field "usbsts", got "usbsts_pending"; skipping rest
> +Section "pci-serial-4x" Description "pci-serial-multi": Entry "Fields" missing
> +Section "intel-hda-generic", Description "intel-hda", Field "pci": missing description
> +Section "cfi.pflash01": Entry "Description" missing
> +Section "megasas", Description "PCIDevice": expected field "irq_state", while dest has no further fields
> +Section "PIIX3-xen" Description "PIIX3": minimum version error: 1 < 2
> +Section "PIIX3-xen" Description "PIIX3": Entry "Subsections" missing
> +Section "tpci200": Description "tpci200" missing, got "tpci2002" instead; skipping
> +Section "sun-fdtwo" Description "fdc": version error: 2 > 1
> +Section "sun-fdtwo", Description "fdrive": Subsection "fdrive/media_rate" not found
> +Section "usb-kbd" Description "usb-kbd" Field "kbd.keycodes" size mismatch: 4 , 2
> +'''
> +
>  class VmStateTest(QemuSystemTest):
>  
>      def run_vmstate_checker(self, src_json, dst_json):
> @@ -19,6 +35,27 @@ def run_vmstate_checker(self, src_json, dst_json):
>                                stderr=subprocess.STDOUT,
>                                text=True)
>  
> +    def test_checker(self):
> +        """
> +        Test whether the checker script correctly detects the changes
> +        between dump1.json and dump2.json.
> +        """
> +        if self.arch != 'x86_64':
> +            self.skipTest('for x86 only')
> +        src_json = self.data_file('..', 'data', 'vmstate-static-checker',
> +                                  'dump1.json')
> +        dst_json = self.data_file('..', 'data', 'vmstate-static-checker',
> +                                  'dump2.json')
> +        self.log.info(f'Comparing {src_json} with {dst_json}')
> +        cp = self.run_vmstate_checker(src_json, dst_json)
> +        if cp.returncode != 13:
> +            self.fail('Unexpected return code of vmstate-static-checker: ' +
> +                      cp.returncode)
> +        if cp.stdout != expected_output:
> +            self.log.info('vmstate-static-checker output:\n' + cp.stdout)
> +            self.log.info('expected output:\n' + expected_output)
> +            self.fail('Unexpected vmstate-static-checker output!')
> +

Would this run for every make check and every CI run?

Since the script almost never change, I wonder whether this test should be
triggered only if manually.  But maybe I totally missed how the functional
framework works..

>      def test_vmstate(self):
>          target_machine = {
>              'aarch64': 'virt-7.2',
> -- 
> 2.49.0
> 

-- 
Peter Xu


