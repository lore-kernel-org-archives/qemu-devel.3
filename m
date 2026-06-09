Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C23CD8CAE
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 04:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWo1G-0004fB-Gv; Tue, 09 Jun 2026 00:24:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWmEq-0003kl-6l
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:30:48 -0400
Received: from mx2.catap.net ([65.21.79.163])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kirill@korins.ky>) id 1wWmEm-0000xl-6U
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:30:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=20240125rsa; cv=none; d=mx.catap.net; b=CVwrygd
 cHxmYYapxCfj0c0Z6IPQG1R8j37wtV5AUGIxBlohwyLHAGqd3af5wEBVAy1czxWwXRsWDa
 zXqeT/wiqR0wRLHirAQtb6/DlrSj5K8DYZlrlFmwjbft3VB1MPHubHNAd7FM8PBnKAqULn
 vuWzAvCc0Om4ed667yzu+dvSF8yYzZ4Ki2IKlGnaG0NZx4c41TPfWOeMx/LhyUuxOfOIFr
 lOmLnbRM9WGSPeUvQDtYZ6+rOA51WnjbeL45RN6cf/kmDAQ2i4qHoTR53dPcmM/IoeiRHQ
 nNaYV+NfKQTEutJjHqos+W8rKiKHTi18HDwGrQrK37jYuUR6ZGqzjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; s=20240125rsa; c=simple/simple; bh=a
 peePpYgDu5cAlGMas75I4F8IWgzRY9YYITbh2BPboo=;
 h=references:in-reply-to:
 subject:to:from:date:dkim-signature:dkim-signature; d=mx.catap.net; b=
 A/qzedBClCNzvYCTdJvB6MgoWlLTQMy06ja5JxHT/kHOWUGV10tBUnnT629VbtvzMMo5lW
 mBeXhJ6xOGMBmVXondHDT8KPpq+YyM6AYJ/I63w9IvUIUGUHIXDNYAupzHJq+TStgu5gJV
 3WeyFy0tjsfTGySHFW1XyilPJmWWixgbMpLU8uomIIsTY/7bKJPOtJFwqgCUUHBVFeuRuC
 ND8lbaaTEsxtHX5Top283b3mEHM+6gtEVu99H8v6KlkWrfU1OQjCxexp60b8hVJ15iqXra
 XsvcUaEZpML5vaDJ38vnknr+8d8QOGutDj2xXOFkeQ0XIqa2UXDYgjlcrYV21Q==
ARC-Authentication-Results: i=1; mx.catap.net; dkim=pass
 header.s=20240125rsa header.d=korins.ky header.a=rsa-sha256 
 header.b=IqAtY/+4; dkim=pass header.s=20240125ed25519 
 header.d=korins.ky header.a=ed25519-sha256 header.b=SZUZd2kA;
 arc=none; iprev=pass; spf=none
 smtp.helo=postmaster@matebook.home.arpa; spf=softfail
 smtp.mailfrom=kirill@korins.ky
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=20240125rsa; bh=apeePpYg
 Du5cAlGMas75I4F8IWgzRY9YYITbh2BPboo=; h=references:in-reply-to:
 subject:to:from:date; d=korins.ky;
 b=IqAtY/+4cBWXJ3EtNfx51cFVri0koT0b2
 RY1RD7rBA/+B1MGC/d0gjm3Fg0+fmpYcpRpBAVsQw8TAvBogJI51oDAC8m+bt7l7ouRFuU
 9MeP827pwgTEdxe7eWMoXwxkzrCi4/r1gdziJfrlcbVBct67AegvESahoYm4yKgyRYc+ff
 xo6hvzlAM++ynHIT7+iUSLDY4sa1ZSBmDvqlvS95AfzFC11dgCWPgDSQhR7EmxdVfsEz0J
 bvXQ1YcSTUnQhxcka2SFMNrkq3ZTiMOenq7FgacxZQ7TguemSPdGnzbGzZjxH/YjcA5u1Y
 6xmydt/0vP0kiR3wsiT0CkSUIoktg==
DKIM-Signature: v=1; a=ed25519-sha256; c=simple/simple; s=20240125ed25519;
 bh=apeePpYgDu5cAlGMas75I4F8IWgzRY9YYITbh2BPboo=; h=references:
 in-reply-to:subject:to:from:date; d=korins.ky; b=SZUZd2kADiuDiUKQSZWrW
 6t5E5AsHJRnfWanvVbKbspHqB1zaOCV+9s9Hi1zgZgmdxRE1Gj+XYabQ7HJgYAkBA==
Received: by mx2.catap.net (OpenSMTPD) with ESMTPSA id 86c52409
 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO); 
 Tue, 9 Jun 2026 04:30:41 +0200 (CEST)
Received: by matebook.home.arpa (OpenSMTPD) with ESMTP id 335e69fe;
 Tue, 9 Jun 2026 04:30:40 +0200 (CEST)
Date: Tue, 09 Jun 2026 04:30:40 +0200
Message-ID: <8733ywtpgv.wl-kirill@korins.ky>
From: Kirill A. Korinsky <kirill@korins.ky>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] powernv: boot OpenBSD on POWER9
In-Reply-To: <20260609021945.73632-1-kirill@korins.ky>
References: <20260609021945.73632-1-kirill@korins.ky>
User-Agent: Wanderlust
Mail-Followup-To: qemu-devel@nongnu.org,
 "Kirill A. Korinsky" <kirill@korins.ky>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart_Tue_Jun__9_04:30:40_2026-1"
Received-SPF: pass client-ip=65.21.79.163; envelope-from=kirill@korins.ky;
 helo=mx2.catap.net
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 09 Jun 2026 00:24:38 -0400
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

--Multipart_Tue_Jun__9_04:30:40_2026-1
Content-Type: text/plain; charset=US-ASCII

On Tue, 09 Jun 2026 04:19:45 +0200,
"Kirill A. Korinsky" <kirill@korins.ky> wrote:
> 
> OpenBSD/powernv programs PTCR for LPID 0 with a partition
> table size exponent one smaller than QEMU's existing ISA v3.0
> interpretation. Try QEMU's existing PATS interpretation first,
> then fall back to the OpenBSD LPID 0 form; nonzero LPIDs keep
> the old behaviour.
> 
> The PSI model now exposes POWER9 IRQ level and pending status
> registers, and keeps both updated while delivering through the
> existing XIVE LSI source. This lets guests that select the
> POWER9 PSI LSI IRQ method continue to receive LPC interrupts.
> 
> The blast radius is probably minimal: the partition table
> fallback is limited to bare metal LPID 0 after the original
> lookup fails, while the PSI change only touches POWER9 PSI
> state and reuses the existing delivery path.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>


It was tested as:

qemu-system-ppc64 \
    -M powernv9 \
    -cpu power9 \
    -m 2G \
    -nographic \
    -kernel pnor.BOOTKERNEL \
    -device ich9-ahci,id=sata0,bus=pcie.0,addr=0x0 \
    -drive file=miniroot79.img,format=raw,if=none,id=bootdisk,snapshot=on \
    -device ide-hd,bus=sata0.0,unit=0,drive=bootdisk,bootindex=1

Where:

1. miniroot79.img from https://cdn.openbsd.org/pub/OpenBSD/snapshots/powerpc64/

2. pnor.BOOTKERNEL was extracted from talos-ii-v2.10.pnor which I get from
https://wiki.raptorcs.com/wiki/File:Talos-ii-pnor-v2.10-bundle.tar by
extract-pnor-bootkernel.pl which I attached.

-- 
wbr, Kirill

--Multipart_Tue_Jun__9_04:30:40_2026-1
Content-Type: text/plain; type=perl; charset=LATIN1; name="extract-pnor-bootkernel.pl"
Content-Disposition: attachment; filename="extract-pnor-bootkernel.pl"
Content-Transfer-Encoding: 7bit

#!/usr/bin/env perl

use strict;
use warnings;

use Fcntl qw(SEEK_SET);
use File::Basename qw(dirname);
use File::Path qw(make_path);

use constant FFS_MAGIC => "PART";
use constant FFS_VERSION => 1;
use constant FFS_MAGIC_SIZE => 4;
use constant FFS_NAME_SIZE => 16;
use constant FFS_UINT32_SIZE => 4;
use constant FFS_RESERVED_SIZE => 16;
use constant COPY_CHUNK => 1024 * 1024;

use constant FFS_HEADER_SIZE =>
    FFS_MAGIC_SIZE + 6 * FFS_UINT32_SIZE + FFS_RESERVED_SIZE +
    FFS_UINT32_SIZE;
use constant FFS_ENTRY_PREFIX_SIZE => FFS_NAME_SIZE + 7 * FFS_UINT32_SIZE;

# OpenPOWER PNOR images use a big-endian FFS partition table.
my @FFS_HEADER_FIELDS = (
    [ magic        => "a" . FFS_MAGIC_SIZE ],
    [ version      => "N" ],
    [ table_blocks => "N" ],
    [ entry_size   => "N" ],
    [ entry_count  => "N" ],
    [ block_size   => "N" ],
    [ block_count  => "N" ],
    [ reserved     => "x" . FFS_RESERVED_SIZE ],
    [ checksum     => "N" ],
);
my @FFS_ENTRY_PREFIX_FIELDS = (
    [ name   => "Z" . FFS_NAME_SIZE ],
    [ base   => "N" ],
    [ blocks => "N" ],
    [ pid    => "N" ],
    [ id     => "N" ],
    [ type   => "N" ],
    [ flags  => "N" ],
    [ actual => "N" ],
);

my $FFS_HEADER_FORMAT = join " ", map { $_->[1] } @FFS_HEADER_FIELDS;
my $FFS_ENTRY_PREFIX_FORMAT = join " ", map { $_->[1] } @FFS_ENTRY_PREFIX_FIELDS;

sub usage {
    die "usage: $0 talos-ii-vXXX.pnor pnor.BOOTKERNEL\n";
}

sub fail {
    die "$0: @_\n";
}

sub read_exact {
    my ($fh, $size, $what) = @_;
    my $buf = "";

    while (length($buf) < $size) {
        my $n = read $fh, $buf, $size - length($buf), length($buf);
        fail("$what: $!") unless defined $n;
        fail("$what: unexpected EOF") if $n == 0;
    }

    return $buf;
}

sub copy_exact {
    my ($in, $out, $size) = @_;

    while ($size > 0) {
        my $want = $size < COPY_CHUNK ? $size : COPY_CHUNK;
        my $buf = read_exact($in, $want, "BOOTKERNEL data");
        print {$out} $buf or fail("write: $!");
        $size -= length($buf);
    }
}

@ARGV == 2 or usage();
my ($pnor, $output) = @ARGV;

open my $fh, "<:raw", $pnor or fail("$pnor: $!");
my $file_size = -s $fh;
defined $file_size or fail("$pnor: cannot stat: $!");

my $header = read_exact($fh, FFS_HEADER_SIZE, "PNOR FFS header");
my ($magic, $version, $table_blocks, $entry_size, $entry_count, $block_size,
    $block_count, undef) = unpack $FFS_HEADER_FORMAT, $header;

fail("PNOR FFS magic not found") if $magic ne FFS_MAGIC;
fail("unsupported PNOR FFS version $version") if $version != FFS_VERSION;
fail("PNOR FFS entry size is too small")
    if $entry_size < FFS_ENTRY_PREFIX_SIZE;

my $table_size = $table_blocks * $block_size;
my $entries_end = FFS_HEADER_SIZE + $entry_count * $entry_size;
my $image_size = $block_count * $block_size;

fail("PNOR FFS table extends past the file") if $table_size > $file_size;
fail("PNOR FFS entries extend past the table") if $entries_end > $table_size;
fail("PNOR FFS image size extends past the file") if $image_size > $file_size;

my ($bootkernel_offset, $bootkernel_size);

for my $i (0 .. $entry_count - 1) {
    my $entry_offset = FFS_HEADER_SIZE + $i * $entry_size;
    seek $fh, $entry_offset, SEEK_SET or fail("seek entry $i: $!");

    my $entry = read_exact($fh, $entry_size, "PNOR FFS entry $i");
    my ($name, $base, $blocks, undef, undef, undef, undef, $actual) =
        unpack $FFS_ENTRY_PREFIX_FORMAT, $entry;

    next if $name eq "";

    my $offset = $base * $block_size;
    my $size = $blocks * $block_size;
    fail("PNOR FFS entry $name extends past the image")
        if $offset + $size > $image_size;
    fail("PNOR FFS entry $name actual size is too large")
        if $actual > $size;

    if ($name eq "BOOTKERNEL") {
        ($bootkernel_offset, $bootkernel_size) = ($offset, $size);
        last;
    }
}

defined $bootkernel_offset or fail("BOOTKERNEL partition not found");

my $dir = dirname($output);
make_path($dir) if $dir ne "." && !-d $dir;

my $tmp = "$output.tmp";
open my $out, ">:raw", $tmp or fail("$tmp: $!");
seek $fh, $bootkernel_offset, SEEK_SET or fail("seek BOOTKERNEL: $!");
copy_exact($fh, $out, $bootkernel_size);
close $out or fail("$tmp: $!");
rename $tmp, $output or do {
    my $err = $!;
    unlink $tmp;
    fail("rename $tmp to $output: $err");
};

printf "wrote %s from %s\n", $output, $pnor;
printf "BOOTKERNEL offset=0x%x size=0x%x\n",
    $bootkernel_offset, $bootkernel_size;

--Multipart_Tue_Jun__9_04:30:40_2026-1--

